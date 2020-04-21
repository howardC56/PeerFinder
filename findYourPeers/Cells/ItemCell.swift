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
    }
    
    public lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    public lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Item Name"
        label.textColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        label.font = UIFont(name: "Kohinoor Telugu", size: 20)
        return label
    }()
    public lazy var datePostedLabel: UILabel = {
        let label = UILabel()
        label.text = "Date Posted"
        label.textColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        label.font = UIFont(name: "Kohinoor Telugu", size: 17)
        return label
    }()
    public lazy var itemPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        label.textAlignment = .center
        label.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
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
            itemImageView.topAnchor.constraint(equalTo: topAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            itemImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3)
        ])
    }
    private func itemNameConstraints() {
        addSubview(itemNameLabel)
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            itemNameLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 8),
            itemNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    private func datePostedConstraints() {
        addSubview(datePostedLabel)
        datePostedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePostedLabel.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 10),
            datePostedLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 8),
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
        datePostedLabel.text = item.datePosted.description
        itemPriceLabel.text = "$\(item.itemPrice)"
    }
}
