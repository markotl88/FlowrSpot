//
//  User.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 04/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let id: Int
    let fullName: String?
    let profilePicture: String?
}
