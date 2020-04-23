//
//  CreateViewGroup.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class CreateViewGroup: UIView {
    
   public lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo.fill")
        image.tintColor = customMainColor
        image.layer.borderWidth = 2
        image.layer.borderColor = customBorderColor.cgColor
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .white
        image.layer.cornerRadius = 10
        return image
    }()
    
    public lazy var changeImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.cornerRadius = 26
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.backgroundColor = customButtonColor
        button.layer.borderWidth = 2
        button.layer.borderColor = customBorderColor.cgColor
        button.tintColor = .white
        button.layer.masksToBounds = true
        button.clipsToBounds = false
        return button
    }()
    
    
    
    public lazy var groupNameTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.black
        tf.font = UIFont(name: "Futura", size: 18.0)
        tf.layer.borderColor = customBorderColor.cgColor
        tf.backgroundColor = .white
        tf.layer.borderWidth = 2.0
        tf.textAlignment = .center
        tf.placeholder = "Enter Name For The Group"
        tf.autocapitalizationType = .words
        tf.layer.cornerRadius = 10
        return tf
    }()
    
    public lazy var groupTopicTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.black
        tf.font = UIFont(name: "Futura", size: 18.0)
        tf.layer.borderColor = customBorderColor.cgColor
        tf.backgroundColor = .white
        tf.layer.borderWidth = 2.0
        tf.textAlignment = .center
        tf.placeholder = "Enter Topic For The Group"
        tf.autocapitalizationType = .words
        tf.layer.cornerRadius = 10
        return tf
    }()
    
    public lazy var descriptionTextField: UITextField = {
        let tv = UITextField()
        tv.textColor = UIColor.black
        tv.font = UIFont(name: "Futura", size: 18.0)
        tv.layer.borderColor = customBorderColor.cgColor
        tv.backgroundColor = .white
        tv.textAlignment = .center
        tv.placeholder = "Enter Description For The Group"
        tv.layer.borderWidth = 2.0
        tv.layer.cornerRadius = 10
        return tv
    }()
    
    public lazy var categorySegmentedControl: UISegmentedControl = {
        let categories = ["Study", "Clubs", "Events"]
        let sc = UISegmentedControl(items: categories)
        sc.selectedSegmentIndex = 0
        sc.tintColor = customHighlight
        sc.backgroundColor = customHighlight
        sc.layer.borderColor = customBorderColor.cgColor
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Futura", size: 18.0), NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 1.0)]
        sc.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        sc.selectedSegmentTintColor = customHighlight
        sc.layer.borderWidth = 2.0
        sc.layer.cornerRadius = 10
        return sc
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        setupImageViewConstraints()
        setupChangeImageButtonConstraints()
        setupCategorySegmentedControlConstraints()
        setupGroupNameTextFieldConstraints()
        setupGroupTopicTextFieldConstraints()
        setupDescriptionTextFieldConstraints()
    }
    
    private func setupImageViewConstraints() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.20),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.50),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupChangeImageButtonConstraints() {
        addSubview(changeImageButton)
        changeImageButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeImageButton.heightAnchor.constraint(equalToConstant: 54),
            changeImageButton.widthAnchor.constraint(equalToConstant: 54),
            changeImageButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            changeImageButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
        ])
    }
    
    private func setupCategorySegmentedControlConstraints() {
        addSubview(categorySegmentedControl)
        categorySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categorySegmentedControl.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            categorySegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            categorySegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setupGroupNameTextFieldConstraints() {
        addSubview(groupNameTextField)
        groupNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupNameTextField.topAnchor.constraint(equalTo: categorySegmentedControl.bottomAnchor, constant: 25),
            groupNameTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05),
            groupNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            groupNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            
        ])
    }
    
    private func setupGroupTopicTextFieldConstraints() {
        addSubview(groupTopicTextField)
        groupTopicTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupTopicTextField.topAnchor.constraint(equalTo: groupNameTextField.bottomAnchor, constant: 25),
            groupTopicTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05),
            groupTopicTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            groupTopicTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setupDescriptionTextFieldConstraints() {
        addSubview(descriptionTextField)
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionTextField.topAnchor.constraint(equalTo: groupTopicTextField.bottomAnchor, constant: 25),
            descriptionTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.30),
            descriptionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
