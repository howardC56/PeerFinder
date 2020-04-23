//
//  ItemCell.swift
//  findYourPeers
//
//  Created by casandra grullon on 4/21/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
       override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = 13
        self.backgroundColor = .clear
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 0, green: 0.382160157, blue: 0.3518279195, alpha: 1)
    }
    
    public lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 13
        imageView.clipsToBounds = true
        return imageView
    }()
    public lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Item Name"
        label.textColor = .black
        label.font = UIFont(name: "Futura", size: 20)
        return label
    }()
    public lazy var datePostedLabel: UILabel = {
        let label = UILabel()
        label.text = "Date Posted"
        label.textColor = .darkGray
        label.font = UIFont(name: "Kohinoor Telugu", size: 17)
        return label
    }()
    public lazy var itemPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = customMainColor
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
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
        itemImageConstraints()
        itemNameConstraints()
        datePostedConstraints()
        priceLabelConstraints()
    }
    private func itemImageConstraints() {
        addSubview(itemImageView)
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            itemImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            itemImageView.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    private func itemNameConstraints() {
        addSubview(itemNameLabel)
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            itemNameLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 20),
            itemNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    private func datePostedConstraints() {
        addSubview(datePostedLabel)
        datePostedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePostedLabel.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 10),
            datePostedLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 20),
            datePostedLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    private func priceLabelConstraints() {
        addSubview(itemPriceLabel)
        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            itemPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            itemPriceLabel.widthAnchor.constraint(equalToConstant: 60 )
        ])
    }
}
extension ItemCell {
    public func configureCell(item: Item) {
        itemNameLabel.text = item.itemName
        datePostedLabel.text = item.datePosted.convertToString()
        let price = String(format: "$%.02f", item.itemPrice)
        itemPriceLabel.text = price
        if let firstImage = item.itemImages.first {
            itemImageView.kf.setImage(with: URL(string: firstImage))
        }
        
    }
}
