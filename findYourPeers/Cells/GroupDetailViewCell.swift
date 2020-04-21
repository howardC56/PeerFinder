//
//  GroupDetailViewCell.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/21/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class GroupDetailViewCell: UITableViewCell {
    
    public lazy var postUserNameLabel: UILabel = {
        let label = UILabel()
        label.text = "user Name"
        label.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        label.font = UIFont(name: "Kohinoor Telugu", size: 14)
        return label
    }()
    public lazy var postLabel: UILabel = {
        let label = UILabel()
        label.text = "comments"
        label.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Kohinoor Telugu", size: 17)
        return label
    }()
    public lazy var dateCreatedLabel: UILabel = {
        let label = UILabel()
        label.text = "created date"
        label.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        label.font = UIFont(name: "Kohinoor Telugu", size: 12)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        dateLabelConstraints()
        postNameSetup()
    }
    
    func configureCell(post: Post) {
        
    }
    
    private func dateLabelConstraints() {
        addSubview(dateCreatedLabel)
        dateCreatedLabel.anchor(top: topAnchor, right: rightAnchor, paddingTop: 10, paddingRight: 10, width: 50, height: 35)
    }
    
    private func postNameSetup() {
        addSubview(postUserNameLabel)
        postUserNameLabel.anchor(top: dateCreatedLabel.topAnchor, left: leftAnchor, right: dateCreatedLabel.leftAnchor, paddingLeft: 15, paddingRight: 20, height: 35)
    }
    
    private func postSetup() {
        addSubview(postLabel)
        postLabel.anchor(top: postUserNameLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
    }

}
