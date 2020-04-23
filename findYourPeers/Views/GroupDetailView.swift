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
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var categoryLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont(name: "Kohinoor Telugu", size: 18)
        label.textColor = .black
           label.adjustsFontSizeToFitWidth = true
           label.text = "category Here"
           label.textAlignment = .left
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
           label.layer.borderColor = customBorderColor.cgColor
           label.text = "Date Posted: , UserName: , Description:"
           label.sizeToFit()
           label.isEditable = false
        label.backgroundColor = .clear
           return label
       }()
    
    public lazy var tableView: UITableView = {
        let tableV = UITableView()
        tableV.rowHeight = 100
        tableV.backgroundColor = .white
        return tableV
    }()
    
    public lazy var commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = customButtonColor
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.cornerRadius = 30
        button.layer.borderColor = customBorderColor.cgColor
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
        //titleLabelSetup()
        categoryLabelSetup()
        descriptionLabelSetup()
        tableViewSetup()
        buttonSetup()
        backgroundColor = customMainColor
    }
    
    private func photoimageSetup() {
    addSubview(photoImageView)
        photoImageView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, paddingTop: 20, paddingLeft: 15, width: 150, height: 180)
    }
    
    private func categoryLabelSetup() {
        addSubview(categoryLabel)
        categoryLabel.anchor(top: safeAreaLayoutGuide.topAnchor, left: photoImageView.rightAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 15)
    }
    
    private func descriptionLabelSetup() {
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: categoryLabel.bottomAnchor, left: categoryLabel.leftAnchor, bottom: photoImageView.bottomAnchor, right: categoryLabel.rightAnchor)
    }
    
    private func tableViewSetup() {
        addSubview(tableView)
        tableView.anchor(top: descriptionLabel.bottomAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingTop: 35)

    }
    
    private func buttonSetup() {
        addSubview(commentButton)
        commentButton.anchor(bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingBottom: 20, paddingRight: 30, width: 60, height: 60)
    }
}
