//
//  GroupsView.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

let customHighlight = #colorLiteral(red: 0.5958901048, green: 0.7962107062, blue: 0.7127075791, alpha: 1)

let customMainColor = #colorLiteral(red: 0.1332651377, green: 0.7317578197, blue: 0.6140573621, alpha: 1)

let customBorderColor = #colorLiteral(red: 0, green: 0.382160157, blue: 0.3518279195, alpha: 1)

let customButtonColor = #colorLiteral(red: 0.1332651377, green: 0.7317578197, blue: 0.6140573621, alpha: 1)

class GroupsView: UIView {
    
    let white = UIColor(white: 1.0, alpha: 1.0)

    public lazy var categorySegmentedControl: UISegmentedControl = {
        let categories = ["All", "Study", "Clubs", "Events",]
        let sc = UISegmentedControl(items: categories)
        sc.selectedSegmentIndex = 0
        sc.tintColor = customHighlight
        sc.backgroundColor = customMainColor
        sc.layer.borderColor = customBorderColor.cgColor
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Futura", size: 18.0), NSAttributedString.Key.foregroundColor: white]
        sc.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        sc.selectedSegmentTintColor = customHighlight
        sc.layer.borderWidth = 2
        sc.layer.cornerRadius = 20
        return sc
        }()
    
    
    public lazy var groupSearchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Enter a group name"
        search.layer.cornerRadius = 20
        search.layer.masksToBounds = true
        search.searchTextField.backgroundColor = .white
        return search
    }()
    
    public lazy var groupsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
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
        button.backgroundColor = customButtonColor
        button.layer.borderWidth = 2
        button.layer.borderColor = customBorderColor.cgColor
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
            groupSearchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            groupSearchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            groupSearchBar.trailingAnchor.constraint(equalTo: trailingAnchor)
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
            groupsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            groupsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            groupsCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpAddButtonConstraints() {
        addSubview(addGroup)
        
        addGroup.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addGroup.trailingAnchor.constraint(equalTo: groupsCollectionView.trailingAnchor, constant: -8),
            addGroup.bottomAnchor.constraint(equalTo: groupsCollectionView.bottomAnchor, constant: -20),
            addGroup.widthAnchor.constraint(equalToConstant: 54),
            addGroup.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    
}
