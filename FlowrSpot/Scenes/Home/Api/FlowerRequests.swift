//
//  FlowerRequests.swift
//  FlowrSpot
//
//  Created by TK on 17/01/2018.
//  Copyright © 2018 PovioLabs. All rights reserved.
//

import Alamofire

enum FlowerRequests: Request {
    case flowersList
    case flowerDetails(flowerid: Int)
    case flowerSightings(flowerid: Int)
    
    var path: String {
        switch self {
        case .flowersList:
            return "flowers"
        case let .flowerDetails(id):
            return "flowers/\(String(id))"
        case let .flowerSightings(id):
            return "flowers/\(String(id))/sightings"
            
        }
    }
}
