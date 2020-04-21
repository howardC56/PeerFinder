//
//  ViewController.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

enum Category {
    case study
    case club
    case event
}

class FollowedGroupsController: UIViewController {

    private let followedGroupsView = FollowedGroupsView()
    
    override func loadView() {
        view = followedGroupsView
        followedGroupsView.backgroundColor = .systemBackground
    }
    private var selectedCategory: Category = .study {
        didSet {
            DispatchQueue.main.async {
                self.followedGroupsView.collectionView.reloadData()
            }
        }
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        followedGroupsView.categorySegmentedControl.addTarget(self, action: #selector(categorySelected(_:)), for: .valueChanged)
        
    }
    private func configureCollectionView() {
        followedGroupsView.collectionView.delegate = self
        followedGroupsView.collectionView.dataSource = self
        followedGroupsView.collectionView.register(GroupCell.self, forCellWithReuseIdentifier: "groupCell")
    }
    @objc private func categorySelected(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedCategory = .study
            //filter groups
        case 1:
            selectedCategory = .club
            //filter groups
        case 2:
            selectedCategory = .event
            //filter groups
        default:
            print("default case hit")
        }
    }
}
extension FollowedGroupsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxsize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxsize.width * 0.9
        let itemHeight: CGFloat = maxsize.height * 0.20
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
extension FollowedGroupsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = followedGroupsView.collectionView.dequeueReusableCell(withReuseIdentifier: "groupCell", for: indexPath) as? GroupCell else {
            fatalError("failed to cast to group cell")
        }
        cell.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //code to segue to group detail
    }
    
}
