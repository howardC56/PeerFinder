//
//  GroupCell.swift
//  findYourPeers
//
//  Created by casandra grullon on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit
import Kingfisher

class GroupCell: UICollectionViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = 13
    }
    
    public lazy var groupImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        label.font = UIFont(name: "Kohinoor Telugu", size: 20)
        return label
    }()
    public lazy var groupTopicLabel: UILabel = {
        let label = UILabel()
        label.text = "Group Topic (math, science, etc)"
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        label.font = UIFont(name: "Kohinoor Telugu", size: 17)
        return label
    }()
    public lazy var dateCreatedLabel: UILabel = {
        let label = UILabel()
        label.text = "created date"
        label.numberOfLines = 1
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
        groupNameLabelConstraints()
        groupTopicLabelConstraints()
    }
    private func groupImageConstraints() {
        addSubview(groupImageView)
        groupImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            groupImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            groupImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            groupImageView.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    private func groupNameLabelConstraints() {
        addSubview(groupNameLabel)
        groupNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            groupNameLabel.leadingAnchor.constraint(equalTo: groupImageView.trailingAnchor, constant: 20),
            groupNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    private func groupTopicLabelConstraints() {
        addSubview(groupTopicLabel)
        groupTopicLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupTopicLabel.topAnchor.constraint(equalTo: groupNameLabel.bottomAnchor, constant: 8),
            groupTopicLabel.leadingAnchor.constraint(equalTo: groupImageView.trailingAnchor, constant: 20),
            groupTopicLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    private func dateCreatedLabelConstraints() {
        addSubview(dateCreatedLabel)
        dateCreatedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateCreatedLabel.topAnchor.constraint(equalTo: groupTopicLabel.bottomAnchor, constant: 8),
            dateCreatedLabel.leadingAnchor.constraint(equalTo: groupImageView.trailingAnchor, constant: 20),
            dateCreatedLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    
}
extension GroupCell {
    public func configureCell(for group: Group) {
        groupImageView.kf.setImage(with: URL(string: group.groupPhotoURL))
        groupNameLabel.text = "\(group.groupName)"
        groupTopicLabel.text = "\(group.topic)"
        dateCreatedLabel.text = "\(group.dateCreated.convertToString())"
    }
}
