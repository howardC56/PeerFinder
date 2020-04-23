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
    private var refreshControl: UIRefreshControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureNavBar()
        configureRefreshControl()
        getMyItems()
    }
    
    @objc private func getMyItems() {
        DatabaseService.manager.getitemFavoriteGroups(item: Item.self) {
            [weak self] (result) in
            switch result {
            case .failure(let error):
                print("could not get myItems: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                }
            case .success(let myItems):
                self?.myItems = myItems
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
    private func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = customMainColor
        itemWishlistView.collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(getMyItems), for: .valueChanged)
    }
    private func configureCollectionView(){
        itemWishlistView.collectionView.delegate = self
        itemWishlistView.collectionView.dataSource = self
        itemWishlistView.collectionView.register(ItemCell.self, forCellWithReuseIdentifier: "itemCell")
    }
    
    private func configureNavBar() {
        navigationItem.title = "My Wishlist"
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
        navigationController?.navigationBar.tintColor = customBorderColor
    }
}

