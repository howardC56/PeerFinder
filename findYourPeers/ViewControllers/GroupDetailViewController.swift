//
//  GroupDetailViewController.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class GroupDetailViewController: UIViewController {

    private var groupDetailView = GroupDetailView()
    //private var group: Group!
    
//    private var posts = [Post]() {
//        didSet {
//            groupDetailView.tableView.reloadData()
//        }
//    }
    
    private var isFavorite = false {
        didSet {
            DispatchQueue.main.async {
                if self.isFavorite == true {
                    self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
            } else {
                    self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star")
            }
            }
        }
    }
    
    lazy private var favorite: UIBarButtonItem = {
                    [unowned self] in
           return UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(configureFavorites(_:)))
                    }()
    
    @objc private func configureFavorites(_ sender: UIBarButtonItem) {
        
    }
    
    override func loadView() {
        view = groupDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.title = group.name.capitalized
        navigationItem.rightBarButtonItem = favorite
        groupDetailView.tableView.delegate = self
        groupDetailView.tableView.dataSource = self
    }
    


}

extension GroupDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //posts.count
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupDetailViewCell", for: indexPath) as? GroupDetailViewCell else {
            fatalError("could not downcast to SearchViewTableViewCell")
        }
        //let post = posts[indexPath.row]
        //cell.configureCell(for: post)
        return cell
    }
    
    
}
