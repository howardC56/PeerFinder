//
//  GroupsView.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class GroupsView: UIView {
    
    public lazy var studyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Study", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.01115901116, green: 0.2440761924, blue: 0.6173175573, alpha: 1)
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 10
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        return button
    }()
    
    public lazy var clubsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clubs", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.01115901116, green: 0.2440761924, blue: 0.6173175573, alpha: 1)
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 10
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        return button
    }()
    
    public lazy var eventsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Events", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.01115901116, green: 0.2440761924, blue: 0.6173175573, alpha: 1)
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 10
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        return button
    }()
    
    
    public lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [studyButton, clubsButton, eventsButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 20
        return stack
    }()
    
    public lazy var groupSearchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Enter a group name"
        search.layer.cornerRadius = 20
        search.layer.masksToBounds = true
        search.barTintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        search.searchTextField.backgroundColor = .white
        return search
    }()
    
    public lazy var groupsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = #colorLiteral(red: 0.9971715808, green: 0.8923018575, blue: 0.4402516186, alpha: 1)
        cv.layer.cornerRadius = 10
        return cv
    }()
    
    public lazy var addGroup: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.cornerRadius = 22
        button.layer.shadowOpacity = 0.25
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.6697600484, blue: 0.7905663848, alpha: 1)
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
        setUpVstack()
        setUpGroupSearchConstraints()
        setUpCVConstraints()
        setUpAddButtonConstraints()
    }
    
    
    private func setUpVstack() {
        addSubview(vStack)
        
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            vStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05)
        ])
    }
    
    private func setUpGroupSearchConstraints() {
        addSubview(groupSearchBar)
        
        groupSearchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            groupSearchBar.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 20),
            groupSearchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            groupSearchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setUpCVConstraints() {
        addSubview(groupsCollectionView)
        
        groupsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            groupsCollectionView.topAnchor.constraint(equalTo: groupSearchBar.bottomAnchor, constant: 20),
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
            addGroup.widthAnchor.constraint(equalToConstant: 44),
            addGroup.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
}
