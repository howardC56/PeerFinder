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
        vc.tabBarItem = UITabBarItem(title: "Search Groups", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        return vc
    }()
    
    public lazy var collectionsViewController: FollowedGroupsController = {
        let vc = FollowedGroupsController()
        vc.tabBarItem = UITabBarItem(title: "Your Groups", image: UIImage(systemName: "person.3"), selectedImage: UIImage(systemName: "person.3.fill"))
        return vc
    }()
    
    public lazy var marketPlaceViewController: MarketPlaceViewController = {
        let vc = MarketPlaceViewController()
        vc.tabBarItem = UITabBarItem(title: "Marketplace", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))
        return vc
    }()
    public lazy var itemWishlistViewController: ItemWishlistViewController = {
        let vc = ItemWishlistViewController()
        vc.tabBarItem = UITabBarItem(title: "Wishlist", image: UIImage(systemName: "bag"), selectedImage: UIImage(systemName: "bag.fill"))
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = customBorderColor
        viewControllers = [UINavigationController(rootViewController: collectionsViewController), UINavigationController(rootViewController: searchViewController),  UINavigationController(rootViewController: marketPlaceViewController),UINavigationController(rootViewController: itemWishlistViewController)]
        
    }
    
}
