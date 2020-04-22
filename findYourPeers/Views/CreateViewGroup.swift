//
//  CreateViewGroup.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class CreateViewGroup: UIView {
    
    let customBlueColor = UIColor(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
    
    let customGoldColor = UIColor(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    
      public lazy var imageView: UIImageView = {
           let image = UIImageView()
        image.image = UIImage(systemName: "photo.fill")
        image.tintColor = customGoldColor
        image.backgroundColor = customBlueColor
        image.layer.cornerRadius = 10
           return image
       }()
    
    public lazy var changeImageButton: UIButton = {
           let button = UIButton()
           button.setBackgroundImage(UIImage(systemName: "plus"), for: .normal)
           button.tintColor = customBlueColor
           return button
       }()
    
    public lazy var groupNameTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.black
        tf.font = UIFont(name: "Kohinoor Telugu", size: 20.0)
        tf.layer.borderColor = customBlueColor.cgColor
        tf.backgroundColor = .white
        tf.layer.borderWidth = 3.0
        tf.textAlignment = .center
        tf.placeholder = "Enter Name For Group"
        tf.autocapitalizationType = .words
        tf.layer.cornerRadius = 10
        return tf
    }()
    
    public lazy var groupTopicTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.black
        tf.font = UIFont(name: "Kohinoor Telugu", size: 20.0)
        tf.layer.borderColor = customBlueColor.cgColor
        tf.backgroundColor = .white
        tf.layer.borderWidth = 3.0
        tf.textAlignment = .center
        tf.placeholder = "Enter Topic For Group"
        tf.autocapitalizationType = .words
        tf.layer.cornerRadius = 10
        return tf
    }()
    
    public lazy var descriptionTextView: UITextView = {
        let tv = UITextView()
        tv.textColor = customBlueColor
        tv.font = UIFont(name: "Kohinoor Telugu", size: 20.0)
        tv.layer.borderColor = customBlueColor.cgColor
        tv.textAlignment = .center
        tv.text = "Enter Description For Group"
        tv.textColor = UIColor.lightGray
        tv.layer.borderWidth = 3.0
        tv.layer.cornerRadius = 10
        return tv
    }()
    
    public lazy var categorySegmentedControl: UISegmentedControl = {
    let categories = ["Study", "Clubs", "Events"]
    let sc = UISegmentedControl(items: categories)
    sc.selectedSegmentIndex = 0
    sc.tintColor = customGoldColor
    sc.backgroundColor = customBlueColor
    sc.layer.borderColor = customBlueColor.cgColor
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Kohinoor Telugu", size: 20.0), NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 1.0)]
    sc.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
    sc.selectedSegmentTintColor = customGoldColor
    sc.layer.borderWidth = 3.0
    sc.layer.cornerRadius = 20
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
        setupDescriptionTextViewConstraints()
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
                  changeImageButton.heightAnchor.constraint(equalToConstant: 40),
                  changeImageButton.widthAnchor.constraint(equalToConstant: 40),
                  changeImageButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
                  changeImageButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
              ])
          }
   
    /*
    var buttonBottomConstraint = NSLayoutConstraint()

    private func configureSubmitButton() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        buttonBottomConstraint = submitButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        buttonBottomConstraint.isActive = true
        submitButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    Then, we will create a function that can reset the constraint.
    public func moveViewsToAccommodateKeyboard(with rect: CGRect, and duration: Double) {
        let size = rect.size
        buttonBottomConstraint.constant = -(size.height + 20)
        UIView.animate(withDuration: duration){
            self.layoutIfNeeded()
        }
    }
 */
    
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
    
    private func setupDescriptionTextViewConstraints() {
           addSubview(descriptionTextView)
           descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
              descriptionTextView.topAnchor.constraint(equalTo: groupTopicTextField.bottomAnchor, constant: 25),
            descriptionTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.30),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            //descriptionTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 100)
           ])
       }
}
