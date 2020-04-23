//
//  FollowView.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class FollowedGroupsView: UIView {
    
    public var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    public lazy var categorySegmentedControl: UISegmentedControl = {
        let categories = ["All", "Study", "Clubs", "Events",]
        let sc = UISegmentedControl(items: categories)
        sc.selectedSegmentIndex = 0
        sc.tintColor = customHighlight
        sc.backgroundColor = customMainColor
        sc.layer.borderColor = customBorderColor.cgColor
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Futura", size: 18.0), NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 1.0)]
        sc.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        sc.selectedSegmentTintColor = customHighlight
        sc.layer.borderWidth = 2
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
            categorySegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
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
