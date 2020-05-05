//
//  SightingsDataMock.swift
//  FlowrSpotTests
//
//  Created by Marko Stajic on 05/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import XCTest

@testable import FlowrSpot

class SightingsDataMock {
  let decoder = JSONDecoder()
  
  init() {
    decoder.keyDecodingStrategy = .convertFromSnakeCase
  }
    
  func mockSightingEntities() -> [Sighting] {
    do {
        let json = try Helper().loadJsonFromFile("sightings")
      let data = try JSONSerialization.data(withJSONObject: json, options: [])
      let container = try decoder.decode(SightingsContainer.self, from: data)
      return container.sightings
    } catch {
      print(error.localizedDescription)
    }
    return []
  }
}
