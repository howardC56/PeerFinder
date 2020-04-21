//
//  Date+Extension.swift
//  findYourPeers
//
//  Created by Maitree Bain on 4/21/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

extension Date{
    
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "EEEE, MM/dd/yyyy HH:mm"
        
        return dateFormatter.string(from: self)
    }
}
