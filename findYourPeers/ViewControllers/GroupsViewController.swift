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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGroupedBackground
        navigationItem.title = "Groups"
        navigationController?.navigationBar.prefersLargeTitles = true
        configureButtons()
    }
    
    private func configureButtons() {
        groupsView.studyButton.addTarget(self, action: #selector(setUpStudyButton), for: .touchUpInside)
        groupsView.clubsButton.addTarget(self, action: #selector(setUpClubsButton), for: .touchUpInside)
        groupsView.eventsButton.addTarget(self, action: #selector(setUpEventsButton), for: .touchUpInside)
        groupsView.addGroup.addTarget(self, action: #selector(addGroupVC), for: .touchUpInside)
    }
    
    private func setUpCollectionView() {
        groupsView.groupsCollectionView.delegate = self
        groupsView.groupsCollectionView.dataSource = self
    }
    
    @objc func setUpStudyButton() {
        print("study")
        //fetch data filtering on topic
    }
    
    @objc func setUpClubsButton() {
        print("clubs")
        //fetch data filtering on topic
    }
    
    @objc func setUpEventsButton() {
        print("events")
        //fetch data filtering on topic
    }
    
    @objc func addGroupVC() {
        print("group insert")
        let createGroupVC = CreateGroupViewController()
        navigationController?.pushViewController(createGroupVC, animated: true)
    }
    

}

extension GroupsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "boop", for: indexPath)
        
        return cell
    }
    
    
}
