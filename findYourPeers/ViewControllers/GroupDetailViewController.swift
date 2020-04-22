//
//  GroupDetailViewController.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit
import Kingfisher

class GroupDetailViewController: UIViewController {

    private var groupDetailView = GroupDetailView()
    private var groupPostView = GroupCommentPostView()
    var group: Group!
    private var post: Bool = false
    
    private var posts = [Post]() {
        didSet {
            groupDetailView.tableView.reloadData()
        }
    }
    
    init(_ group: Group) {
        self.group = group
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        if isFavorite {
            DatabaseService.manager.deleteGroupFromFavorites(group.self) { [weak self] (result) in
                       switch result {
                       case .failure(let error):
                           self?.showAlert(title: "error", message: error.localizedDescription)
                       case .success:
                           self?.isFavorite = false
                               }
                           }
               } else {
                   DatabaseService.manager.addGroupToFavorties(group) { [weak self] (result) in
                       switch result {
                       case .failure(let error):
                           self?.showAlert(title: "error", message: error.localizedDescription)
                       case .success:
                           self?.isFavorite = true
                       }
                   }
               }
    }
    
    private func isGroupFavorited(_ group: Group) {
        DatabaseService.manager.groupIsFavorited(group) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.showAlert(title: "error", message: error.localizedDescription)
            case .success(let success):
                if success {
                    self?.isFavorite = true
                } else {
                    self?.isFavorite = false
                }
            }
        }
    }
    
    override func loadView() {
        view = groupDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = group.groupName.capitalized
        navigationItem.rightBarButtonItem = favorite
        groupDetailView.tableView.delegate = self
        groupDetailView.tableView.dataSource = self
        groupDetailView.tableView.register(GroupDetailViewCell.self, forCellReuseIdentifier: "GroupDetailViewCell")
        configureDetails()
        //isGroupFavorited(group)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
            groupPostView.addGestureRecognizer(tap)

    }

    @objc func dismissKeyboard() {
           view.endEditing(true)
       }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        isGroupFavorited(group)
    }
    
    private func configureDetails() {
        groupDetailView.photoImageView.kf.setImage(with: URL(string: group.groupPhotoURL))
        groupDetailView.categoryLabel.text = "Category: \(group.category)"
        groupDetailView.descriptionLabel.text = "created by: \(group.createdBy) \n\(group.description)"
        groupDetailView.titleLabel.text = group.groupName
        groupDetailView.commentButton.addTarget(self, action: #selector(postButtonPressed(_:)), for: .touchUpInside)
        groupPostView.cancelButton.addTarget(self, action: #selector(cancelButtonPressed(_:)), for: .touchUpInside)
    }

    @objc private func postButtonPressed(_ sender: UIButton) {
        post = true
        view = groupPostView
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc private func cancelButtonPressed(_ sender: UIButton) {
        post = false
        groupPostView.descriptionLabel.text = ""
        groupPostView.descriptionLabel.placeholder = "Comment"
        view = groupDetailView
        navigationController?.navigationBar.isHidden = false
    }
}

extension GroupDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupDetailViewCell", for: indexPath) as? GroupDetailViewCell else {
            fatalError("could not downcast to SearchViewTableViewCell")
        }
        let post = posts[indexPath.row]
        cell.configureCell(post: post)
        return cell
    }
    
    
}

