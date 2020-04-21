//
//  MainTabBarController.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    public lazy var searchViewController: GroupsViewController = {
        let vc = GroupsViewController()
        vc.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.3"), selectedImage: UIImage(systemName: "person.3.fill"))
        return vc
    }()
    
    public lazy var collectionsViewController: FollowedGroupsController = {
        let vc = FollowedGroupsController()
        vc.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.2.square.stack"), selectedImage: UIImage(systemName: "person.2.square.stack.fill"))
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        viewControllers = [UINavigationController(rootViewController: searchViewController), UINavigationController(rootViewController: collectionsViewController)]
        
    }
    
}
