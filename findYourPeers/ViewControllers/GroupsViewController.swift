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

        view.backgroundColor = UIColor(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        configureButtons()
    }
    
    private func configureButtons() {
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
