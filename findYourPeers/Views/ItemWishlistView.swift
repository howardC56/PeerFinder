//
//  ItemWishlistView.swift
//  findYourPeers
//
//  Created by casandra grullon on 4/21/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class ItemWishlistView: UIView {
    
     public var collectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
         let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
         cv.backgroundColor = .white
         cv.layer.cornerRadius = 10
         return cv
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
         collectionViewConstraints()
     }
     
     private func collectionViewConstraints() {
         addSubview(collectionView)
         collectionView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
             collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
             collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
             collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
         ])
     }
}
