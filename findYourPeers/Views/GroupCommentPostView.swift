//
//  GroupCommentPostView.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/22/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class GroupCommentPostView: UIView {

    public lazy var descriptionLabel: UITextField = {
        let label = UITextField()
        label.font = UIFont(name: "Kohinoor Telugu", size: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor
        label.sizeToFit()
        label.placeholder = "Comment"
        label.contentVerticalAlignment = .top
        label.setLeftPadding(10)
        label.setRightPadding(10)
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
    
    public lazy var cancelButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 350, y: 520, width: 50, height: 50))
        button.setTitle("Cancel", for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = false
        button.tintColor = .blue
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.clear.cgColor
        button.layer.borderWidth = 1.5
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
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
        backgroundColor = .white
        descriptionLabelSetup()
        submitButtonSetup()
        cancelButtonConstraints()
    }
    
    private func descriptionLabelSetup() {
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20, height: 150)
    }
    
    private func submitButtonSetup() {
        addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([submitButton.centerYAnchor.constraint(equalTo: centerYAnchor), submitButton.centerXAnchor.constraint(equalTo: centerXAnchor), submitButton.widthAnchor.constraint(equalToConstant: 100)])
    }
    
    private func cancelButtonConstraints() {
        addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([cancelButton.centerXAnchor.constraint(equalTo: centerXAnchor), cancelButton.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 40), cancelButton.widthAnchor.constraint(equalToConstant: 100), cancelButton.heightAnchor.constraint(equalToConstant: 50)])
    }

}
