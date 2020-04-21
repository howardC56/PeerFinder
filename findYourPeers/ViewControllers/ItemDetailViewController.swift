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
    
    //add image picker controller here

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName:  "camera.fill"), style: .plain, target: self, action: #selector(loadCamera))
    }
    
    @objc private func loadCamera() {
        print("camera opened")
    }

}
