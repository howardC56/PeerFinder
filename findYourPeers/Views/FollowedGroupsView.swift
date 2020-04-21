//
//  FollowView.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class FollowedGroupsView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        studyButton.clipsToBounds = true
        studyButton.layer.cornerRadius = 13
        eventButton.clipsToBounds = true
        eventButton.layer.cornerRadius = 13
        clubButton.clipsToBounds = true
        clubButton.layer.cornerRadius = 13
    }
    public var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        return cv
    }()
    public lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [studyButton, clubButton, eventButton])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = 5
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    public lazy var studyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Study Groups", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Kohinoor Telugu", size: 20)
        return button
    }()
    public lazy var clubButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clubs", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Kohinoor Telugu", size: 20)
        return button
    }()
    public lazy var eventButton: UIButton = {
        let button = UIButton()
        button.setTitle("Events", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Kohinoor Telugu", size: 20)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        stackConstraints()
        collectionViewConstraints()
    }
    private func stackConstraints() {
        addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            buttonStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            buttonStack.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    private func collectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
