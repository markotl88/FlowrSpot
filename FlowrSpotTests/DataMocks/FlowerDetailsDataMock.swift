//
//  FlowerDetailsDataMock.swift
//  FlowrSpotTests
//
//  Created by Marko Stajic on 05/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import Foundation
@testable import FlowrSpot

class FlowerDetailsDataMock {
  let decoder = JSONDecoder()
  
  init() {
    decoder.keyDecodingStrategy = .convertFromSnakeCase
  }
    
  func mockFlowerEntity() -> Flower? {
    do {
        let json = try Helper().loadJsonFromFile("flower")
      let data = try JSONSerialization.data(withJSONObject: json, options: [])
      let container = try decoder.decode(FlowerContainer.self, from: data)
      return container.flower
    } catch {
      print(error.localizedDescription)
    }
    return nil
  }
}

