//
//  Post.swift
//  findYourPeers
//
//  Created by Howard Chang on 4/20/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import Foundation

struct Post: Codable {
    let userName: String
    let userId: String
    let timePosted: Date
    let postText: String
    let postId: String
    
}
