//
//  Group.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import Foundation

struct Group: Codable {
    let category: String
    let collegeName: String
    let createdBy: String
    let creatorId: String
    let dateCreated: Date
    let description: String
    let id: String
    let groupName: String
    let groupPhotoURL: String
    let topic: String
}
