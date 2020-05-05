//
//  GetFlowerSightingsWorker.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 04/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import Foundation

class GetFlowerSightingsWorker {
    var downloader = FlowersDownloader()
    
    func execute(flowerId: Int, success: RestClient.SuccessCompletion<[Sighting]>, failure: RestClient.FailureCompletion) {
        downloader.fetchFlowerSightings(flowerId: flowerId, success: success, failure: failure)
    }
}
