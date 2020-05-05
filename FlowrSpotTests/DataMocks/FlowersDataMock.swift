//
//  File.swift
//  FlowrSpotTests
//
//  Created by TK on 22/01/2018.
//  Copyright © 2018 PovioLabs. All rights reserved.
//

import Foundation
@testable import FlowrSpot

class FlowersDataMock {
  let decoder = JSONDecoder()
  
  init() {
    decoder.keyDecodingStrategy = .convertFromSnakeCase
  }
    
  func mockFlowerEntities() -> [Flower] {
    do {
        let json = try Helper().loadJsonFromFile("flowers")
      let data = try JSONSerialization.data(withJSONObject: json, options: [])
      let container = try decoder.decode(FlowersContainer.self, from: data)
      return container.flowers
    } catch {
      print(error.localizedDescription)
    }
    return []
  }
}
