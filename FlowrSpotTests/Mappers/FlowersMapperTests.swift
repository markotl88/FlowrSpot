//
//  FlowersMapperTests.swift
//  FlowrSpotTests
//
//  Created by TK on 22/01/2018.
//  Copyright © 2018 PovioLabs. All rights reserved.
//

import XCTest
@testable import FlowrSpot

class FlowersMapperTests: XCTestCase {
    
      let names = ["Goosefoot Violet",
                   "Goosefoot Violet 2",
                   "Goosefoot Violet 3",
                   "Goosefoot Violet 4",
                   "Goosefoot Violet 5"]
      
      let latinNames = ["Viola purpurea 1",
                   "Viola purpurea 2",
                   "Viola purpurea 3",
                   "Viola purpurea 4",
                   "Viola purpurea 5"]
      
      let sightings = [1, 10, 50, 20, 30]
      
      let favorites = [false, true, true, true, true]

    
    func testMapping() {
      let entities = FlowersDataMock().mockFlowerEntities()
      XCTAssertEqual(entities.count, 5)
      
      for i in 0..<entities.count {
        let entity = entities[i]
        XCTAssertEqual(entity.name, names[i])
        XCTAssertEqual(entity.latinName, latinNames[i])
        XCTAssertEqual(entity.sightings, sightings[i])
        XCTAssertEqual(entity.favorite, favorites[i])
      }
    }
}
