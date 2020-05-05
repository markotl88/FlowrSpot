//
//  ReverseGeocoder.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 05/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import Foundation
import CoreLocation

class ReverseGeocoder {
    static func getCity(latitude: Double, longitude: Double, completion: @escaping (([String]) -> Void)) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        geoCoder.reverseGeocodeLocation(location) { (placemarks, _) in
            var cities = [String]()
            
            placemarks?.forEach({ (placemark) in
                cities.append(placemark.locality ?? "unknown_location".localized())
            })
            
            completion(cities)
        }
    }
}
