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
                self.items = self.items.filter {$0.itemName.contains(self.searchQuery.lowercased())}
            }
        }
    }
    private var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureSearchBar()
        configureNavBar()
        configureRefreshControl()
        configureButton()
        getItems()
    }
    @objc private func getItems() {
        DatabaseService.manager.getItems(item: Item.self) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("could not get items \(error)")
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                }
            case .success(let items):
                self?.items = items
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                }
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
    private func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        marketPlaceView.collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(getItems), for: .valueChanged)
    }
    private func configureNavBar() {
        navigationItem.title = "Student Market Place"
    }
    private func configureButton() {
        marketPlaceView.addItemButton.addTarget(self, action: #selector(addItemButtonPressed(_:)), for: .touchUpInside)
    }
    @objc private func addItemButtonPressed(_ sender: UIButton) {
        let createItemVC = CreateItemViewController()
        present(createItemVC, animated: true)
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
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]

        let itemDetailVC = ItemDetailViewController(item)
        navigationController?.pushViewController(itemDetailVC, animated: true)
        navigationController?.navigationBar.tintColor = customBorderColor
    }
    
    
}
extension MarketPlaceViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            searchQuery = searchText
        }
    }
}
