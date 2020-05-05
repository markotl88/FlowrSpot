//
//  Helper.swift
//  FlowrSpotTests
//
//  Created by Marko Stajic on 05/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import Foundation
@testable import FlowrSpot

class Helper {
    func loadJsonFromFile(_ file: String) throws -> Any {
      guard let path = Bundle(for: type(of: self)).path(forResource: file, ofType: "json") else { throw RemoteResourceError.generic }
      
      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
      return jsonResult
    }
}
