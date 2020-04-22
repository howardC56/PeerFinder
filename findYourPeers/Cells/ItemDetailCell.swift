//
//  ItemDetailCell.swift
//  findYourPeers
//
//  Created by Maitree Bain on 4/22/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class ItemDetailCell: UICollectionViewCell {
    
    public lazy var imageView: UIImageView = {
        let image = UIImageView()
      image.image = UIImage(systemName: "photo.fill")
      image.tintColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
      image.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
      image.layer.cornerRadius = 10
         return image
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
        setUpImageConstraints()
    }
    
    private func setUpImageConstraints() {
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configureCell(for item: Item) {
        
//        imageView.kf.setImage(with: item.itemImages)
        
    }
}
