//
//  ItemDetailView.swift
//  findYourPeers
//
//  Created by casandra grullon on 4/21/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class ItemDetailView: UIView {
    
    public lazy var itemName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Kohinoor Telugu", size: 24)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.text = "Item Name"
        label.numberOfLines = 3
        return label
    }()
    
    public lazy var sellerName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Kohinoor Telugu", size: 16)
        label.textColor = .darkGray
        label.adjustsFontSizeToFitWidth = true
        label.text = "Seller Name"
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    public lazy var contactSellerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Contact Seller", for: .normal)
        button.backgroundColor = customHighlight
        button.titleLabel?.textColor = .black
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = customBorderColor.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 10
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        return button
    }()
    
    public lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo.fill")
        image.layer.borderWidth = 2
        image.layer.borderColor = customBorderColor.cgColor
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    public lazy var itemsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = customHighlight
        cv.layer.borderWidth = 2
        cv.layer.borderColor = customBorderColor.cgColor
        cv.layer.cornerRadius = 10
        return cv
    }()
    
    public lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Kohinoor Telugu", size: 20)
        label.textColor = .darkText
        label.text = "Price: "
        label.numberOfLines = 1
        return label
    }()
    
    public lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Kohinoor Telugu", size: 18)
        label.textColor = .darkText
        label.text = "Condition: "
        label.numberOfLines = 1
        return label
    }()
    
    public lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Kohinoor Telugu", size: 16)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.text = "Description:"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
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
        setUpContactConstraints()
        setUpItemNameConstraints()
        setUpSellerNameConstraints()
        setUpItemImageConstraints()
        setUpImagesCollectionConstraints()
        setUpPriceConstraints()
        setUpConditionConstraints()
        setUpDescripConstraints()
    }
    
    private func setUpContactConstraints() {
        addSubview(contactSellerButton)
        
        contactSellerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contactSellerButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            contactSellerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            contactSellerButton.widthAnchor.constraint(equalToConstant: 120),
            contactSellerButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setUpItemNameConstraints() {
        addSubview(itemName)
        
        itemName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            itemName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            itemName.trailingAnchor.constraint(equalTo: contactSellerButton.leadingAnchor, constant: 8)
        ])
    }
    
    private func setUpSellerNameConstraints() {
        addSubview(sellerName)
        
        sellerName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sellerName.topAnchor.constraint(equalTo: itemName.bottomAnchor, constant: 8),
            sellerName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
    
    private func setUpItemImageConstraints() {
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: sellerName.bottomAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
        ])
    }
    
    private func setUpImagesCollectionConstraints() {
        addSubview(itemsCollectionView)
        
        itemsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemsCollectionView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            itemsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            itemsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            itemsCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1)
        ])
    }
    
    private func setUpPriceConstraints() {
        addSubview(priceLabel)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: itemsCollectionView.bottomAnchor, constant: 20),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
    
    private func setUpConditionConstraints() {
        addSubview(conditionLabel)
        
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            conditionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 14),
            conditionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
        
    }
    
    private func setUpDescripConstraints(){
        addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
}
