//
//  GroupsViewController.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController {
    
    let groupsView = GroupsView()
    
    override func loadView() {
        view = groupsView
    }
    
    private var groups = [Group]() {
        didSet{
            DispatchQueue.main.async {
                self.groupsView.groupsCollectionView.reloadData()
            }
        }
    }
    
    private var newGroups = [Group]() {
        didSet{
            DispatchQueue.main.async {
                self.groupsView.groupsCollectionView.reloadData()
            }
        }
    }
    
    var isFirst = false
    
    private var searchQuery = "" {
        didSet {
            if isFirst == true{
                groups = groups.filter { $0.groupName.lowercased().contains(searchQuery.lowercased())}
                print("groups:" + searchQuery)
            } else {
                newGroups = newGroups.filter { $0.groupName.lowercased().contains(searchQuery.lowercased())}
                print(searchQuery)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Groups"
        configureSegButtons()
        setUpCollectionView()
        isFirst = true
        groupsView.groupSearchBar.delegate = self
        getGroups()
    }
    
    private func configureSegButtons() {
        groupsView.categorySegmentedControl.addTarget(self, action: #selector(categoryChosen(_:)), for: .valueChanged)
        groupsView.addGroup.addTarget(self, action: #selector(addGroupVC), for: .touchUpInside)
    }
    
    @objc private func categoryChosen(_ sender: UISegmentedControl) {
        isFirst = false
        switch sender.selectedSegmentIndex {
        case 0:
            isFirst = true
            getGroups()
        case 1:
            newGroups = groups.filter {$0.category == "study"}
            print(isFirst)
        case 2:
            newGroups = groups.filter {$0.category == "club"}
            print(isFirst)
        case 3:
            newGroups = groups.filter {$0.category == "event"}
            print(isFirst)
        default:
            print("default case hit")
        }
    }
    
    private func setUpCollectionView() {
        groupsView.groupsCollectionView.delegate = self
        groupsView.groupsCollectionView.dataSource = self
        groupsView.groupsCollectionView.register(GroupCell.self, forCellWithReuseIdentifier: "groupCell")
    }
    
    private func getGroups() {
        DatabaseService.manager.getGroups(item: Group.self) { [weak self] (result) in
            switch result{
            case .failure(let error):
                print("no groups available: \(error)")
            case .success(let groups):
                self?.groups = groups
            }
        }
    }
    
    @objc func addGroupVC() {
        print("group insert")
        let createGroupVC = CreateGroupViewController()
        present(createGroupVC, animated: true)
    }
    
}

extension GroupsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxsize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxsize.width * 0.9
        let itemHeight: CGFloat = maxsize.height * 0.15
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFirst == true {
            return groups.count
        } else {
            return newGroups.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "groupCell", for: indexPath) as? GroupCell else {
            fatalError("could not downcast to groupCell")
        }
        cell.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        
        if isFirst == false {
            let group = newGroups[indexPath.row]
            cell.configureCell(for: group)
        } else {
            let group = groups[indexPath.row]
            cell.configureCell(for: group)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isFirst == true {
            let group = groups[indexPath.row]
            let groupDetailVC = GroupDetailViewController(group)
            groupDetailVC.group = group
            navigationController?.pushViewController(groupDetailVC, animated: true)
        } else {
            let group = newGroups[indexPath.row]
            let groupDetailVC = GroupDetailViewController(group)
            groupDetailVC.group = group
            navigationController?.pushViewController(groupDetailVC, animated: true)
        }
    }
    
}

extension GroupsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        searchQuery = searchText
        
    }
}
