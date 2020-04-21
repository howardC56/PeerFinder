//
//  GroupCell.swift
//  findYourPeers
//
//  Created by casandra grullon on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class GroupCell: UICollectionViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = 13
    }
    
    public lazy var groupImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    public lazy var labelStack: UIStackView = {
        
        let stack = UIStackView(arrangedSubviews: [groupNameLabel, groupTopicLabel, dateCreatedLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 5
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    public lazy var groupNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Group Name"
        label.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        label.font = UIFont(name: "Kohinoor Telugu", size: 20)
        return label
    }()
    public lazy var groupTopicLabel: UILabel = {
        let label = UILabel()
        label.text = "Group Topic (math, science, etc)"
        label.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        label.font = UIFont(name: "Kohinoor Telugu", size: 17)
        return label
    }()
    public lazy var dateCreatedLabel: UILabel = {
        let label = UILabel()
        label.text = "created date"
        label.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        label.font = UIFont(name: "Kohinoor Telugu", size: 17)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        groupImageConstraints()
        labelStackConstraints()
    }
    private func groupImageConstraints() {
        addSubview(groupImageView)
        groupImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupImageView.topAnchor.constraint(equalTo: topAnchor),
            groupImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            groupImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            groupImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3)
        ])
    }
    private func labelStackConstraints() {
        addSubview(labelStack)
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            labelStack.leadingAnchor.constraint(equalTo: groupImageView.trailingAnchor, constant: 10),
            labelStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            labelStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
}
extension GroupCell {
    private func configureCell() {
        //TODO: - add configure cell for group model
    }
}
