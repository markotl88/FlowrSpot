//
//  Sighting.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 04/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import Foundation

struct Sighting: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case picture
        case likesCount = "likes_count"
        case commentsCount = "comments_count"
        case createdAt = "created_at"
        case latitude
        case longitude
        case user
        case flower
    }
    
    let id: Int
    let name: String
    let description: String
    let picture: String
    let likesCount: Int?
    let commentsCount: Int?
    let createdAt: String?
    let latitude: Double
    let longitude: Double
    let user: User?
    let flower: Flower
}
