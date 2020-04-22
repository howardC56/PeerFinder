//
//  MarketPlaceView.swift
//  findYourPeers
//
//  Created by casandra grullon on 4/21/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class MarketPlaceView: UIView {

    public var searchBar: UISearchBar = {
       let searchbar = UISearchBar()
        searchbar.searchTextField.backgroundColor = .white
        searchbar.placeholder = "search by item name"
        return searchbar
    }()
    
    public var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.layer.cornerRadius = 10
        return cv
    }()
    public lazy var addItemButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.cornerRadius = 27
        button.layer.shadowOpacity = 0.25
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        button.tintColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        searchbarConstraints()
        collectionViewConstraints()
        setUpAddButtonConstraints()
    }
    
    private func searchbarConstraints() {
        addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func collectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
        private func setUpAddButtonConstraints() {
            addSubview(addItemButton)
            addItemButton.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                addItemButton.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: -8),
                addItemButton.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -20),
                addItemButton.widthAnchor.constraint(equalToConstant: 54),
                addItemButton.heightAnchor.constraint(equalToConstant: 54)
            ])
        }
}
