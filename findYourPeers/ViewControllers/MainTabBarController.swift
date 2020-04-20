//
//  MainTabBarController.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    lazy var searchViewController: GroupsViewController = {
           let vc = GroupsViewController()
           vc.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
           return vc
       }()
    
       lazy var collectionsViewController: FollowedGroupsController = {
           let vc = FollowedGroupsController()
           vc.tabBarItem = UITabBarItem(title: "Collections", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
           return vc
       }()
       
       override func viewDidLoad() {
           super.viewDidLoad()
        viewControllers = [UINavigationController(rootViewController: searchViewController), UINavigationController(rootViewController: collectionsViewController)]
           
       }

}
