//
//  FollowView.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class FollowedGroupsView: UIView {
    let customBlueColor = UIColor(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
    
    let customGoldColor = UIColor(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    
    public var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        return cv
    }()
    public lazy var categorySegmentedControl: UISegmentedControl = {
        let categories = ["Study", "Clubs", "Events"]
        let sc = UISegmentedControl(items: categories)
        sc.selectedSegmentIndex = 0
        sc.selectedSegmentTintColor = customGoldColor
        sc.tintColor = customBlueColor
        sc.backgroundColor = .white
        sc.layer.borderColor = customBlueColor.cgColor
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Kohinoor Telugu", size: 20.0), NSAttributedString.Key.foregroundColor: customBlueColor]
        sc.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        sc.layer.borderWidth = 3.0
        sc.layer.cornerRadius = 20
        return sc
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
        segmentControlConstraints()
        collectionViewConstraints()
    }
    private func segmentControlConstraints() {
        addSubview(categorySegmentedControl)
        categorySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categorySegmentedControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            categorySegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            categorySegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            categorySegmentedControl.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.10)
        ])
    }
    private func collectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: categorySegmentedControl.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
