//
//  ItemDetailCell.swift
//  findYourPeers
//
//  Created by Maitree Bain on 4/22/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class ItemDetailCell: UICollectionViewCell {
    
    public lazy var label: UILabel = {
        let label = UILabel()
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
        
    }
}
