//
//  FlowerDetailsDataSourceTests.swift
//  FlowrSpotTests
//
//  Created by Marko Stajic on 05/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import XCTest

@testable import FlowrSpot

class FlowerDetailsDataSourceTests: XCTestCase {
    private let sightings = SightingsDataMock().mockSightingEntities()
    private let dataSource = FlowerDetailsDataSource()
    
    func testDataSource() {
        dataSource.update(sightings: sightings)
        
        XCTAssertTrue(dataSource.sections.count == 1)
        XCTAssertTrue(dataSource.sections.first?.rows.count == sightings.count)
        
        for i in 0..<sightings.count {
            let row = dataSource.row(at: IndexPath(row: i, section: 0))
            XCTAssertNotNil(row)
            
            if let row = row {
                switch row {
                case let .sighting(entity):
                    XCTAssertEqual(sightings[i].name, entity.name)
                }
            }
        }
    }
}
