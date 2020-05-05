//
//  SightingsMapperTests.swift
//  FlowrSpotTests
//
//  Created by Marko Stajic on 05/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import XCTest

@testable import FlowrSpot

class SightingsMapperTests: XCTestCase {
    
    let ids = [1, 2, 14]
    let names = ["Violet Sighting", "Yoyo", "flower"]
    let descriptions = ["Saw it near a bush where the road bends left.",
                        "Keyo",
                        "very nice flower"]
    let likesCount = [2, 0, 0]
    let commentsCount = [1, 0, 0]
    let userNames = ["Nejc Novak", "omer istoomer", "mahir mahir"]
    let latitudes = [46.056946, 1.234, 18.0456]
    let longitudes = [14.505751, 1.432, 20.46787]
    let createdDates = ["2017-09-11T13:38:33.287Z", "2019-06-26T07:28:43.142Z", "2020-01-23T21:21:19.412Z"]
    
    func testMapping() {
      let entities = SightingsDataMock().mockSightingEntities()
      XCTAssertEqual(entities.count, 3)
      
      for i in 0..<entities.count {
        let entity = entities[i]
        XCTAssertEqual(entity.id, ids[i])
        XCTAssertEqual(entity.name, names[i])
        XCTAssertEqual(entity.description, descriptions[i])
        XCTAssertEqual(entity.likesCount, likesCount[i])
        XCTAssertEqual(entity.commentsCount, commentsCount[i])
        XCTAssertEqual(entity.user?.fullName, userNames[i])
        XCTAssertEqual(entity.flower.name, "Goosefoot Violet")
        XCTAssertEqual(entity.latitude, latitudes[i])
        XCTAssertEqual(entity.longitude, longitudes[i])
        XCTAssertEqual(entity.createdAt, createdDates[i])
      }
    }
}
