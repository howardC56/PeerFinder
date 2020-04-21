//
//  GroupDetailViewCell.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/21/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class GroupDetailViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
    }

}
