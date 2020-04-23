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
    
    private var refreshControl: UIRefreshControl!
    
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
    
    private var selectedCategory: Category = .all {
        didSet{
            DispatchQueue.main.async {
                self.groupsView.groupsCollectionView.reloadData()
            }
        }
    }
    
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
    
    private func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = customButtonColor
        groupsView.groupsCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(getGroups), for: .valueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Groups"
        configureRefreshControl()
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
            selectedCategory = .all
            isFirst = true
            getGroups()
        case 1:
            selectedCategory = .study
            isFirst = false
            newGroups = groups.filter {$0.category == selectedCategory.rawValue}
            print(isFirst)
        case 2:
            selectedCategory = .club
            isFirst = false
            newGroups = groups.filter {$0.category == selectedCategory.rawValue}
            print(isFirst)
        case 3:
            selectedCategory = .event
            isFirst = false
            newGroups = groups.filter {$0.category == selectedCategory.rawValue}
            print(isFirst)
        default:
            print("default case hit")
        }
    }
    
    @objc private func getGroups() {
        DatabaseService.manager.getGroups(item: Group.self) { (result) in
            
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "Could not load groups: \(error.localizedDescription)")
                    self.refreshControl.endRefreshing()
                }
            case .success(let groups):
                
                if self.isFirst {
                    self.newGroups = groups
                    self.groups = groups
                    DispatchQueue.main.async {
                        self.refreshControl.endRefreshing()
                    }
                } else {
                    self.newGroups = groups.filter { $0.category == self.selectedCategory.rawValue}
                    DispatchQueue.main.async {
                        self.refreshControl.endRefreshing()
                    }
                }
            }
        }

    }
    
    private func setUpCollectionView() {
        groupsView.groupsCollectionView.delegate = self
        groupsView.groupsCollectionView.dataSource = self
        groupsView.groupsCollectionView.register(GroupCell.self, forCellWithReuseIdentifier: "groupCell")
    }
    
    @objc func addGroupVC(_ sender: UIButton) {
        let createGroupVC = CreateGroupViewController()
        present(UINavigationController(rootViewController: createGroupVC), animated: true)
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
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else { return }
        
        if searchText.isEmpty {
            getGroups()
        }
        searchQuery = searchText
    }
}
