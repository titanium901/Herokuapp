//
//  User.swift
//  frogogo
//
//  Created by Yury Popov on 17/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import Foundation

struct User: Decodable {
    let id: Int
    let firstName, lastName, email: String
    let avatarURL: String?
    let createdAt, updatedAt: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case avatarURL = "avatar_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case url
    }
}


