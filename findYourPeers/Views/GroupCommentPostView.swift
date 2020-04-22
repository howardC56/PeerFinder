//
//  GroupCommentPostView.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/22/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class GroupCommentPostView: UIView {

    public lazy var descriptionLabel: UITextView = {
        let label = UITextView()
        label.font = UIFont(name: "Kohinoor Telugu", size: 16)
        label.textColor = UIColor(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        label.textAlignment = .left
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor
        label.text = "Comment"
        label.sizeToFit()
        label.isEditable = false
        return label
    }()
    
    public lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Post", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.01115901116, green: 0.2440761924, blue: 0.6173175573, alpha: 1)
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 10
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
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
        backgroundColor = UIColor(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        descriptionLabelSetup()
        submitButtonSetup()
    }
    
    private func descriptionLabelSetup() {
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20, height: 150)
    }
    
    private func submitButtonSetup() {
        addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([submitButton.centerYAnchor.constraint(equalTo: centerYAnchor), submitButton.centerXAnchor.constraint(equalTo: centerXAnchor)])
    }

}
