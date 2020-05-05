//
//  FlowerDescriptionDataSource.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 05/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import PovioKit

class FlowerDescriptionDataSource: NSObject {
    
    private var flower: Flower?
    
    func update(flower: Flower) {
        self.flower = flower
    }
    
    func getDescription() -> String {
        return flower?.description ?? ""
    }
    
    func getFeatures() -> [String]? {
        return flower?.features
    }
}
