//
//  User.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 04/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import Foundation

struct User: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case profilePicture
    }
    
    let id: Int
    let fullName: String?
    let profilePicture: String?
}
