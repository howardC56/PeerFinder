//
//  CreateItemViewController.swift
//  findYourPeers
//
//  Created by casandra grullon on 4/22/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

enum ItemCondition: String {
    case new = "new"
    case used = "used"
}

class CreateItemViewController: UIViewController {
    
    private let createItemView = CreateItemView()
    
    override func loadView() {
        view = createItemView
        view.backgroundColor = .white
    }
    private lazy var imagePickerController: UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.delegate = self
        return ip
    }()
    private var selectedImage: UIImage? {
        didSet {
            createItemView.itemImage.image = selectedImage
        }
    }
    
    private var itemImages = [UIImage]() {
        didSet {
            createItemView.itemImageCollection.reloadData()
        }
    }
    private var imageURLs = [String]()
    private var condition: String?
    private var selectedCondition: ItemCondition = .new {
        didSet {
            condition = selectedCondition.rawValue
        }
    }
    private var keyboardIsVisible = false
    private var collectionViewConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureCollectionView()
        configureButton()
        configureTextfield()
        registerKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unregisterKeyboardNotifications()
    }
    private func configureTextfield() {
        createItemView.itemDescriptionTextField.delegate = self
        createItemView.itemNameTextField.delegate = self
        createItemView.itemPriceTextField.delegate = self
    }
    private func configureNavBar() {
        navigationItem.title = "Add Item"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(finishedButtonPressed(_:)))
        navigationItem.rightBarButtonItem?.tintColor = customBorderColor
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(xbuttonPressed(_:)))
        navigationItem.leftBarButtonItem?.tintColor = customBorderColor
    }
    private func configureCollectionView() {
        createItemView.itemImageCollection.delegate = self
        createItemView.itemImageCollection.dataSource = self
        createItemView.itemImageCollection.register(ItemDetailCell.self, forCellWithReuseIdentifier: "itemImageCell")
    }
    private func configureButton() {
        createItemView.addImageButton.addTarget(self, action: #selector(addPhotoButtonPressed(_:)), for: .touchUpInside)
        createItemView.itemConditionSC.addTarget(self, action: #selector(selectedItemCondition(_:)), for: .valueChanged)
    }
    @objc private func xbuttonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    @objc private func selectedItemCondition(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedCondition = .new
        case 1:
            selectedCondition = .used
        default:
            print("default")
        }
    }
    
    @objc private func addPhotoButtonPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Choose Photo Option", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default)
        {[weak self] alertAction in self?.imagePickerController.sourceType = .camera
            self?.present(self!.imagePickerController, animated: true)
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) {[weak self] alertAction in self?.imagePickerController.sourceType = .photoLibrary
            self?.present(self!.imagePickerController, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    @objc private func finishedButtonPressed(_ sender: UIBarButtonItem) {
        guard let itemName = createItemView.itemNameTextField.text, !itemName.isEmpty,
            let itemPrice = createItemView.itemPriceTextField.text, !itemPrice.isEmpty, let priceDouble = Double(itemPrice) ,
            let itemDescription = createItemView.itemDescriptionTextField.text, !itemDescription.isEmpty, let itemCondition = condition,
         let selectedImage = selectedImage else {
                DispatchQueue.main.async {
                    self.showAlert(title: "Missing Fields", message: "Please fill in all fields")
                }
                return
        }
        let id = UUID().uuidString
        let resizedImage = UIImage.resizeImage(originalImage: selectedImage, rect: createItemView.itemImage.bounds)
        var imageURL = String()
        
        FireBaseStorage.shared.uploadPhoto(itemID: id, image: resizedImage) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "Issues saving image \(error.localizedDescription)")
                }
            case .success(let url):
                imageURL = url.absoluteString
                let newItem = Item(datePosted: Date(), id: id, itemCondition: itemCondition, itemDescription: itemDescription, itemImages: self!.imageURLs, itemName: itemName, itemPrice: priceDouble, sellerEmail: "antonioflores@pursuit.org", sellerId: "6cy5BFsR14xyjGXWBvDq", sellerName: "Antonio Flores")
                self?.createItem(item: newItem)
                self?.dismiss(animated: true)
            }
        }

    }
    private func createItem(item: Item) {
        DatabaseService.manager.createItem(item) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "unable to create item \(error.localizedDescription)")
                }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "Success", message: "\(item.itemName) was added to the Marketplace!")
                }
                
                
            }
        }
    }
    
}
extension CreateItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension CreateItemViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 1
        let maxWidth = CGFloat(80)
        let numberOfItems: CGFloat = 1
        let totalSpace: CGFloat = numberOfItems * itemSpacing
        let itemWidth: CGFloat = (maxWidth - totalSpace) / numberOfItems
        
        return CGSize(width: itemWidth, height: 80)
    }
}
extension CreateItemViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = createItemView.itemImageCollection.dequeueReusableCell(withReuseIdentifier: "itemImageCell", for: indexPath) as? ItemDetailCell else {
            fatalError("could not cast to ItemDetailCell")
        }
        let image = itemImages[indexPath.row]
        cell.imageView.image = image
        return cell
    }


}
extension CreateItemViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
            let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL else {
                       return
                   }
            selectedImage = image
        itemImages.append(selectedImage!)
        imageURLs.append(imageURL.absoluteString)
            createItemView.itemImageCollection.backgroundColor = .clear
        
        dismiss(animated: true)
    }
}
extension CreateItemViewController {
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    private func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    @objc private func keyboardWillShow(_ notification: Notification) {
        view.frame.origin.y = -200
    }
    @objc private func keyboardWillHide(_ notification: Notification) {
        dismissKeyboard()
    }
    @objc private func dismissKeyboard() {
        view.frame.origin.y = 0
    }
}
