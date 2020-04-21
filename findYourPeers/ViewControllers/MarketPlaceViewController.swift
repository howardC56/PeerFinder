//
//  MarketPlaceViewController.swift
//  findYourPeers
//
//  Created by casandra grullon on 4/21/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit
import FirebaseFirestore

class MarketPlaceViewController: UIViewController {
    
    private let marketPlaceView = MarketPlaceView()
    
    override func loadView() {
        view = marketPlaceView
        view.backgroundColor = .white
    }
    private var listener: ListenerRegistration?
    
    private var items = [Item]() {
        didSet {
            DispatchQueue.main.async {
                self.marketPlaceView.collectionView.reloadData()
            }
        }
    }
    private var searchQuery = "" {
        didSet {
            DispatchQueue.main.async {
                self.items = self.items.filter {$0.itemName == (self.searchQuery.lowercased())}
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureSearchBar()
        configureNavBar()
        getItems()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //add listener function
//        Firestore.firestore().addSnapshotsInSyncListener {
//            <#code#>
//        }

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        listener?.remove()
    }
    private func getItems() {
        DatabaseService.manager.getItems(item: Item.self) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("could not get items \(error)")
            case .success(let items):
                self?.items = items
            }
        }
    }
    private func configureCollectionView(){
        marketPlaceView.collectionView.delegate = self
        marketPlaceView.collectionView.dataSource = self
        marketPlaceView.collectionView.register(ItemCell.self, forCellWithReuseIdentifier: "itemCell")
    }
    private func configureSearchBar() {
        marketPlaceView.searchBar.delegate = self
    }
    private func configureNavBar() {
        navigationItem.title = "Student Market Place"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
    }
    
    
}
extension MarketPlaceViewController: UICollectionViewDelegateFlowLayout {
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
extension MarketPlaceViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = marketPlaceView.collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as? ItemCell else {
            fatalError("failed to cast to ItemCell")
        }
        let item = items[indexPath.row]
        cell.configureCell(item: item)
        cell.backgroundColor = #colorLiteral(red: 0.9971715808, green: 0.8923018575, blue: 0.4402516186, alpha: 1)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        let itemDetailVC = ItemDetailViewController()
        //itemDetailVC.item = itxem
    }
    
    
}
extension MarketPlaceViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            searchQuery = searchText
        }
    }
}
