//
//  GroupsView.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class GroupsView: UIView {
    
    let customBlueColor = UIColor(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
    
    let customGoldColor = UIColor(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    
    let white = UIColor(white: 1.0, alpha: 1.0)

    public lazy var categorySegmentedControl: UISegmentedControl = {
        let categories = ["Study", "Clubs", "Events", "All"]
        let sc = UISegmentedControl(items: categories)
        sc.selectedSegmentIndex = UISegmentedControl.noSegment
        sc.tintColor = customGoldColor
        sc.backgroundColor = customBlueColor
        sc.layer.borderColor = customBlueColor.cgColor
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Kohinoor Telugu", size: 20.0), NSAttributedString.Key.foregroundColor: white]
        sc.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        sc.selectedSegmentTintColor = customGoldColor
        sc.layer.borderWidth = 3.0
        sc.layer.cornerRadius = 20
        return sc
        }()
    
    
    public lazy var groupSearchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Enter a group name"
        search.layer.cornerRadius = 20
        search.layer.masksToBounds = true
        search.barTintColor = customBlueColor
        search.searchTextField.backgroundColor = .white
        return search
    }()
    
    public lazy var groupsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        cv.layer.cornerRadius = 10
        return cv
    }()
    
    public lazy var addGroup: UIButton = {
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
        setUpGroupSearchConstraints()
        setUpSegConstraints()
        setUpCVConstraints()
        setUpAddButtonConstraints()
    }

    
    private func setUpGroupSearchConstraints() {
        addSubview(groupSearchBar)
        
        groupSearchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            groupSearchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            groupSearchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            groupSearchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setUpSegConstraints() {
        addSubview(categorySegmentedControl)
        
        categorySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            categorySegmentedControl.topAnchor.constraint(equalTo: groupSearchBar.bottomAnchor, constant: 14),
            categorySegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            categorySegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setUpCVConstraints() {
        addSubview(groupsCollectionView)
        
        groupsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            groupsCollectionView.topAnchor.constraint(equalTo: categorySegmentedControl.bottomAnchor, constant: 20),
            groupsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            groupsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            groupsCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.50)
        ])
    }
    
    private func setUpAddButtonConstraints() {
        addSubview(addGroup)
        
        addGroup.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addGroup.topAnchor.constraint(equalTo: groupsCollectionView.bottomAnchor, constant: 8),
            addGroup.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            addGroup.widthAnchor.constraint(equalToConstant: 54),
            addGroup.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    
}
