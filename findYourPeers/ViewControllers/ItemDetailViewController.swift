//
//  ItemDetailViewController.swift
//  findYourPeers
//
//  Created by casandra grullon on 4/21/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    let itemDetailView = ItemDetailView()
    
    override func loadView() {
        view = itemDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }
    

}
