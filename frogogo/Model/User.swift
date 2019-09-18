//
//  User.swift
//  frogogo
//
//  Created by Yury Popov on 17/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import Foundation

struct User: Codable, Equatable {
    var id: Int?
    let firstName, lastName, email: String
    let avatarURL: String?
    var createdAt, updatedAt: String?
    var url: String?
    
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

extension User {
    init(firstName: String, lastName: String, email: String, avatarURL: String = "") {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.avatarURL = avatarURL
    }
}


