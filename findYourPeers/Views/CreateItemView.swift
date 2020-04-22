//
//  CreateItemView.swift
//  findYourPeers
//
//  Created by casandra grullon on 4/22/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit
class CreateItemView: UIView {
    let customBlueColor = UIColor(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
    
    let customGoldColor = UIColor(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    let white = UIColor(white: 1.0, alpha: 1.0)
    
    public lazy var itemImageCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .lightGray
        return cv
    }()
    public lazy var addImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Photo", for: .normal)
        button.layer.cornerRadius = 13
        button.layer.shadowOpacity = 0.25
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        button.tintColor = .white
        return button
    }()
    public lazy var itemNameTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "enter item name"
        textField.borderStyle = .line
        textField.textAlignment = .center
        return textField
    }()
    public lazy var itemPriceTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "enter price for item"
        textField.keyboardType = .numbersAndPunctuation
        textField.borderStyle = .line
        textField.textAlignment = .center
        return textField
    }()
    public lazy var itemDescriptionTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "enter item details"
        textField.textAlignment = .center
        textField.borderStyle = .line
        return textField
    }()
    public lazy var itemConditionSC: UISegmentedControl = {
        let conditions = ["New", "Used"]
        let sc = UISegmentedControl(items: conditions)
        sc.selectedSegmentIndex = 0
        sc.tintColor = customGoldColor
        sc.backgroundColor = customBlueColor
        sc.layer.borderColor = customBlueColor.cgColor
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Kohinoor Telugu", size: 20.0), NSAttributedString.Key.foregroundColor: white]
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
    private func commonInit() {
        collectionViewConstraints()
        addButtonConstraints()
        itemNameConstraints()
        itemPriceConstraints()
        itemConditionConstraints()
        itemDescriptionConstraints()
    }
    private func collectionViewConstraints() {
        addSubview(itemImageCollection)
        itemImageCollection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemImageCollection.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            itemImageCollection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            itemImageCollection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            itemImageCollection.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
        ])
    }
    private func addButtonConstraints() {
        addSubview(addImageButton)
        addImageButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addImageButton.topAnchor.constraint(equalTo: itemImageCollection.bottomAnchor, constant: 10),
            addImageButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    private func itemNameConstraints() {
        addSubview(itemNameTextField)
        itemNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemNameTextField.topAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: 20),
            itemNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            itemNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    private func itemPriceConstraints() {
        addSubview(itemPriceTextField)
        itemPriceTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemPriceTextField.topAnchor.constraint(equalTo: itemNameTextField.bottomAnchor, constant: 20),
            itemPriceTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            itemPriceTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    private func itemConditionConstraints() {
        addSubview(itemConditionSC)
        itemConditionSC.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemConditionSC.topAnchor.constraint(equalTo: itemPriceTextField.bottomAnchor, constant: 20),
            itemConditionSC.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            itemConditionSC.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    private func itemDescriptionConstraints() {
        addSubview(itemDescriptionTextField)
        itemDescriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemDescriptionTextField.topAnchor.constraint(equalTo: itemConditionSC.bottomAnchor, constant: 20),
            itemDescriptionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            itemDescriptionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            itemDescriptionTextField.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

