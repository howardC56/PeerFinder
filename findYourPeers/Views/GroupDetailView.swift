//
//  GroupDetailView.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

final class GroupDetailView: UIView {
    
    public lazy var photoImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Kohinoor Telugu", size: 20)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.text = "Title Here"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var categoryLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont(name: "Kohinoor Telugu", size: 18)
        label.textColor = .black
           label.adjustsFontSizeToFitWidth = true
           label.text = "category Here"
           label.textAlignment = .center
           label.numberOfLines = 0
           return label
       }()
    
     public lazy var descriptionLabel: UITextView = {
           let label = UITextView()
           label.font = UIFont(name: "Kohinoor Telugu", size: 16)
           label.textColor = .black
           label.textAlignment = .left
           label.layer.cornerRadius = 10
           label.layer.borderWidth = 1
           label.layer.borderColor = UIColor(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor
           label.text = "Date Posted: , UserName: , Description:"
           label.sizeToFit()
           label.isEditable = false
           return label
       }()
    
    public lazy var tableView: UITableView = {
        let tableV = UITableView()
        tableV.rowHeight = 100
        tableV.backgroundColor = .white
        return tableV
    }()
    
    public lazy var commentBox: UITextField = {
       let comment = UITextField()
        comment.placeholder = "comment here"
        return comment
    }()
    
    public lazy var commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = UIColor(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        button.layer.shadowColor = UIColor.darkGray.cgColor
        //button.layer.shadowPath = UIBezierPath(roundedRect: button.bounds, cornerRadius: 25).cgPath
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor
        button.layer.borderWidth = 1.5
        button.layer.masksToBounds = true
        button.clipsToBounds = false
        button.animateButtonView(self)
        return button
    }()
    
    override init(frame:CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        photoimageSetup()
        titleLabelSetup()
        categoryLabelSetup()
        descriptionLabelSetup()
        tableViewSetup()
        //commentBoxSetup()
        buttonSetup()
        backgroundColor = .white
    }
    
    private func photoimageSetup() {
    addSubview(photoImageView)
        photoImageView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, paddingTop: 20, paddingLeft: 15, width: 150, height: 150)
    }
    
    private func titleLabelSetup() {
        addSubview(titleLabel)
        titleLabel.anchor(top: safeAreaLayoutGuide.topAnchor, left: photoImageView.rightAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 15)
    }
    
    private func categoryLabelSetup() {
        addSubview(categoryLabel)
        categoryLabel.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, right: titleLabel.rightAnchor, paddingTop: 20)
    }
    
    private func descriptionLabelSetup() {
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: categoryLabel.bottomAnchor, left: titleLabel.leftAnchor, right: titleLabel.rightAnchor, height: 80)
    }
    
    private func tableViewSetup() {
        addSubview(tableView)
        tableView.anchor(top: descriptionLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 35, height: 300)
    }
    
//    private func commentBoxSetup() {
//        addSubview(commentBox)
//        commentBox.anchor(top: tableView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: 15, paddingLeft: 30, paddingBottom: 30, width: bounds.width * 0.75)
//    }
    
    private func buttonSetup() {
        addSubview(commentButton)
        commentButton.anchor(top: tableView.bottomAnchor, right: rightAnchor, paddingTop: 20, paddingRight: 30, width: 60, height: 60)
    }
}
