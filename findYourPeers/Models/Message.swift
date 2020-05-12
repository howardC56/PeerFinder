//
//  UserMessage.swift
//  findYourPeers
//
//  Created by Maitree Bain on 5/12/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import Foundation
import Firebase

struct Message {
    let text: String
    let createdBy: String
    let creatorID: String
    let postedDate: Date
}
