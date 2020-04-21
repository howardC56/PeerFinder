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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = "Groups"
        navigationController?.navigationBar.prefersLargeTitles = true
        configureButtons()
        setUpCollectionView()
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
        groupsView.groupsCollectionView.register(GroupCell.self, forCellWithReuseIdentifier: "groupCell")
    }
    
    @objc func setUpStudyButton() {
        print("study")
        //fetch data filtering on topic
        DatabaseService.manager.getGroups(item: Group.self) {
            [weak self] (result) in
            
            switch result {
            case .failure(let error):
                print("could not fetch groups: \(error)")
            case .success(let groups):
                self?.groups = groups
                dump(groups)
            }
        }
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
//        let createGroupVC = CreateGroupViewController()
//        navigationController?.pushViewController(createGroupVC, animated: true)
        
        let itemVC = ItemDetailViewController()
        navigationController?.pushViewController(itemVC, animated: true)
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
        return groups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "groupCell", for: indexPath) as? GroupCell else {
            fatalError("could not downcast to groupCell")
        }
        cell.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        
        let group = groups[indexPath.row]
        cell.configureCell(for: group)
        
        return cell
    }
    
    
}
