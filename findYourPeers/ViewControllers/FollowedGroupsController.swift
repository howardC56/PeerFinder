//
//  ViewController.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class FollowedGroupsController: UIViewController {

    private let followedGroupsView = FollowedGroupsView()
    
    override func loadView() {
        view = followedGroupsView
        followedGroupsView.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureButtonActions()
    }
    private func configureCollectionView() {
        //followedGroupsView.collectionView.delegate = self
        //followedGroupsView.collectionView.dataSource = self
        //followedGroupsView.collectionView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellWithReuseIdentifier: <#T##String#>)
    }
    private func configureButtonActions() {
        followedGroupsView.studyButton.addTarget(self, action: #selector(studyButtonPressed(_:)), for: .touchUpInside)
        followedGroupsView.clubButton.addTarget(self, action: #selector(clubButtonPressed(_:)), for: .touchUpInside)
        followedGroupsView.eventButton.addTarget(self, action: #selector(eventButtonPressed(_:)), for: .touchUpInside)
    }
    @objc private func studyButtonPressed(_ sender: UIButton) {
        //filter by study groups
    }
    @objc private func clubButtonPressed(_ sender: UIButton) {
        //filter by clubs
    }
    @objc private func eventButtonPressed(_ sender: UIButton) {
        //filter by events
    }

}

