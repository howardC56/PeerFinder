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

        view.backgroundColor = .darkGray
        groupsView.studyButton.addTarget(self, action: #selector(setUpStudyButton), for: .touchUpInside)
        groupsView.clubsButton.addTarget(self, action: #selector(setUpClubsButton), for: .touchUpInside)
        groupsView.eventsButton.addTarget(self, action: #selector(setUpEventsButton), for: .touchUpInside)
    }
    
    @objc func setUpStudyButton() {
        print("study")
    }
    
    @objc func setUpClubsButton() {
        print("clubs")
    }
    
    @objc func setUpEventsButton() {
        print("events")
    }

}
