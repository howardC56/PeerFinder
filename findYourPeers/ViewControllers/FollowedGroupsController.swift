//
//  ViewController.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit
import FirebaseFirestore

enum Category: String {
    case all = "all"
    case study = "study"
    case club = "club"
    case event = "event"
}

class FollowedGroupsController: UIViewController {
    
    private let followedGroupsView = FollowedGroupsView()
    
    override func loadView() {
        view = followedGroupsView
        followedGroupsView.backgroundColor = .white
    }
    private var allGroups = [Group]()
    private var followedGroups = [Group]() {
        didSet {
            DispatchQueue.main.async {
                self.followedGroupsView.collectionView.reloadData()
            }
        }
    }
    
    private var selectedCategory: Category = .all {
        didSet {
            DispatchQueue.main.async {
                self.followedGroupsView.collectionView.reloadData()
            }
        }
    }
    private var refreshControl: UIRefreshControl!
    private var isFiltered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureSegmentControllerAndNavBar()
        fetchFollowedGroups()
        configureRefreshControl()
    }
    
    private func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = customMainColor
        followedGroupsView.collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(fetchFollowedGroups), for: .valueChanged)
    }
    @objc private func fetchFollowedGroups() {
        DatabaseService.manager.getFavoriteGroups(item: Group.self, completion: { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("could not get user's groups \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                }
            case .success(let groups):
                if self?.isFiltered ?? false {
                    self?.allGroups = groups.filter { $0.groupName == self?.selectedCategory.rawValue}
                    DispatchQueue.main.async {
                        self?.refreshControl.endRefreshing()
                    }
                } else {
                    self?.allGroups = groups
                    self?.followedGroups = groups
                    DispatchQueue.main.async {
                        self?.refreshControl.endRefreshing()
                    }
                }
                
            }
            
        })
    }
    
    private func configureCollectionView() {
        followedGroupsView.collectionView.delegate = self
        followedGroupsView.collectionView.dataSource = self
        followedGroupsView.collectionView.register(GroupCell.self, forCellWithReuseIdentifier: "groupCell")
    }
    private func configureSegmentControllerAndNavBar() {
        followedGroupsView.categorySegmentedControl.addTarget(self, action: #selector(categorySelected(_:)), for: .valueChanged)
        navigationItem.title = "Your Groups"
    }
    @objc private func categorySelected(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedCategory = .all
            isFiltered = false
            followedGroups = allGroups
        case 1:
            selectedCategory = .study
            isFiltered = true
            followedGroups = allGroups.filter {$0.category == selectedCategory.rawValue}
        case 2:
            selectedCategory = .club
            isFiltered = true
            followedGroups = allGroups.filter {$0.category == selectedCategory.rawValue}
        case 3:
            selectedCategory = .event
            isFiltered = true
            followedGroups = allGroups.filter {$0.category == selectedCategory.rawValue}
        default:
            print("default case hit")
        }
    }
}
extension FollowedGroupsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxsize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxsize.width * 0.9
        let itemHeight: CGFloat = maxsize.height * 0.15
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
extension FollowedGroupsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followedGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = followedGroupsView.collectionView.dequeueReusableCell(withReuseIdentifier: "groupCell", for: indexPath) as? GroupCell else {
            fatalError("failed to cast to group cell")
        }
        let group = followedGroups[indexPath.row]
        cell.configureCell(for: group)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let group = followedGroups[indexPath.row]
        let groupDetailVC = GroupDetailViewController(group)
        navigationController?.pushViewController(groupDetailVC, animated: true)
        
    }
    
}
