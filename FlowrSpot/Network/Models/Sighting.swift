//
//  Sighting.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 04/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import Foundation

struct Sighting: Codable {
        
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
