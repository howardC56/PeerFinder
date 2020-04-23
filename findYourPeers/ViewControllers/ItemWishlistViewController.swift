//
//  ItemWishlistViewController.swift
//  findYourPeers
//
//  Created by casandra grullon on 4/21/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ItemWishlistViewController: UIViewController {
    
    let customBlueColor = UIColor(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
    
    let customGoldColor = UIColor(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    
    private let itemWishlistView = ItemWishlistView()
    
    override func loadView() {
        view = itemWishlistView
        view.backgroundColor = .white
    }
    
    
    
    private var myItems = [Item]() {
        didSet {
            DispatchQueue.main.async {
                self.itemWishlistView.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureNavBar()
        getMyItems()
    }
    
    @objc private func getMyItems() {
        DatabaseService.manager.getitemFavoriteGroups(item: Item.self) {
            (result) in
            switch result {
            case .failure(let error):
                print("could not get myItems: \(error.localizedDescription)")
            case .success(let myItems):
                self.myItems = myItems
            }
        }
    }
    
    private func configureCollectionView(){
        itemWishlistView.collectionView.delegate = self
        itemWishlistView.collectionView.dataSource = self
        itemWishlistView.collectionView.register(ItemCell.self, forCellWithReuseIdentifier: "itemCell")
    }
    
    private func configureNavBar() {
        navigationItem.title = "My Wishlist"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: customBlueColor,
                                                                   NSAttributedString.Key.font: UIFont(name: "Kohinoor Telugu", size: 20.0) as Any]
    }
}

extension ItemWishlistViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxsize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxsize.width * 0.9
        let itemHeight: CGFloat = maxsize.height * 0.20
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

extension ItemWishlistViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = itemWishlistView.collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as? ItemCell else {
            fatalError("failed to cast to ItemCell")
        }
        let myItem = myItems[indexPath.row]
        cell.configureCell(item: myItem)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let myItem = myItems[indexPath.row]
        let itemDetailVC = ItemDetailViewController(myItem)
        navigationController?.pushViewController(itemDetailVC, animated: true)
    }
}

