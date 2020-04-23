//
//  ItemDetailViewController.swift
//  findYourPeers
//
//  Created by casandra grullon on 4/21/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit
import AVFoundation
import MessageUI

class ItemDetailViewController: UIViewController {
    
    let itemDetailView = ItemDetailView()
    
    override func loadView() {
        view = itemDetailView
    }
    
    public var item: Item
    
    private var currentIndex = 0
    
    init(_ item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var images = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.itemDetailView.itemsCollectionView.reloadData()
            }
        }
    }
    
    private var isInBag = false {
        didSet{
            if isInBag {
                navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bag.fill.badge.plus")
            } else {
                navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bag.badge.plus")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        images = item.itemImages
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bag.badge.plus"), style: .plain, target: self, action: #selector(addToCartAction(_:)))
        navigationItem.rightBarButtonItem?.tintColor = customBorderColor
        itemDetailView.contactSellerButton.addTarget(self, action: #selector(openMailController(_:)), for: .touchUpInside)
        setUpCollectionView()
        updateUI()
    }
    
    private func updateUI() {
        itemDetailView.itemName.text = "\(item.itemName)"
        itemDetailView.sellerName.text = "Seller: \(item.sellerName)"
        itemDetailView.priceLabel.text = "Price: \(item.itemPrice)"
        itemDetailView.conditionLabel.text = "Condition: \(item.itemCondition)"
        itemDetailView.descriptionLabel.text = "\(item.itemDescription)"
        itemDetailView.imageView.kf.setImage(with: URL(string: item.itemImages.first ?? ""))
        favCheck()
    }
    
    private func favCheck() {
        DatabaseService.manager.itemIsFavorited(item) { [weak self] (result) in
            
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                  self?.showAlert(title: "Try again", message: error.localizedDescription)
                }
            case .success(let success):
                if success {
                    self?.isInBag = true
                } else {
                    self?.isInBag = false
                }
            }
        }
    }
    
    private func setUpCollectionView(){
        itemDetailView.itemsCollectionView.delegate = self
        itemDetailView.itemsCollectionView.dataSource = self
        itemDetailView.itemsCollectionView.register(ItemDetailCell.self, forCellWithReuseIdentifier: "itemDetailCell")
    }
    
    @objc private func addToCartAction(_ sender: UIBarButtonItem){
        
        if isInBag {
            DatabaseService.manager.deleteItemFromFavorites(item) { [weak self] (result) in
                
                switch result {
                case .failure(let error):
                    print("could not delete from cart: \(error.localizedDescription)")
                case .success:
                    print("deleted from cart")
                    self?.isInBag = false
                }
            }
        } else {
        DatabaseService.manager.addItemToFavorties(item) { [weak self] (result) in
            
            switch result {
            case .failure(let error):
                print("could not add to cart: \(error.localizedDescription)")
            case .success:
                print("added to cart")
                self?.isInBag = true
            }
        }
        }
    }
    
    @objc private func openMailController(_ sender: UIButton) {
        print("mail")
            //turn this into an action sheet
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let emailAction = UIAlertAction(title: "Send an e-mail", style: .default) { (alertAction) in
                self.showMailComposer()
            }
            let messageAction = UIAlertAction(title: "Send a message", style: .default) { (alertAction) in
                //add message controller here
                self.showMessageComposer()
            }
            alertController.addAction(emailAction)
            alertController.addAction(messageAction)
            present(alertController, animated: true)

    }
    
    private func showMailComposer() {
        
        guard MFMailComposeViewController.canSendMail() else {
            //show alert
            DispatchQueue.main.async {
                self.showAlert(title: "Device Error", message: "Your device cannot send e-mails")
            }
            return }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([item.sellerEmail])
        composer.setSubject("Interested in \(item.itemName)")
        composer.setMessageBody("I would like to purchase the item listed", isHTML: false)
        present(composer, animated: true)
    }
    
    private func showMessageComposer() {
        
        if !MFMessageComposeViewController.canSendText() {
            DispatchQueue.main.async {
                self.showAlert(title: "Device Error", message: "Your device cannot send e-mails")
            }
        }
        
        let messageComposer = MFMessageComposeViewController()
        messageComposer.body = "Hi! I'm interested in this item that you're selling."
        messageComposer.recipients = ["3474699643"]
        messageComposer.messageComposeDelegate = self
        
        guard let image = itemDetailView.imageView.image else { return }
        
        if let imageData = image.jpegData(compressionQuality: 1.0){
            messageComposer.addAttachmentData(imageData, typeIdentifier: "public.data", filename: "item_image")
        }else {
            DispatchQueue.main.async {
                self.showAlert(title: "No image selected", message: "Did not attach an image to message")
            }
        }
        present(messageComposer, animated: true)
    }
    
}

extension ItemDetailViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        switch result {
        case .cancelled:
            print("cancelled message")
            dismiss(animated: true)
        case .failed:
            print("message failed to send")
            dismiss(animated: true)
        case .sent:
            print("message sent")
            dismiss(animated: true)
        default:
            print("default")
        }
    }
    
    
}

extension ItemDetailViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
            controller.dismiss(animated: true)
        }

        switch result {
        case .cancelled:
            print("cancelled email")
        case .failed:
            print("failed to send email")
        case .saved:
            print("saved email")
        case .sent:
            print("email sent!")
        default:
            print("default ")
            controller.dismiss(animated: true)
        }
        
        controller.dismiss(animated: true)
    }
}

extension ItemDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 1
        let maxWidth = UIScreen.main.bounds.width * 0.2
        let numberOfItems: CGFloat = 1
        let totalSpace: CGFloat = numberOfItems * itemSpacing
        let itemWidth: CGFloat = (maxWidth - totalSpace) / numberOfItems
        
        return CGSize(width: itemWidth, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemDetailCell", for: indexPath) as? ItemDetailCell else {
            fatalError("could not downcast to ItemDetailCell")
        }
        
        let image = images[indexPath.row]
        cell.configureCell(for: image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = images[indexPath.row]
        currentIndex = indexPath.row
        itemDetailView.imageView.kf.setImage(with: URL(string: image))
    }
    
}
