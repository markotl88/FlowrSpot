//
//  GetFlowerDetailsWorker.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 01/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import Foundation

class GetFlowerDetailsWorker {
    var downloader = FlowersDownloader()
    
    func execute(flowerId: Int, success: RestClient.SuccessCompletion<Flower>, failure: RestClient.FailureCompletion) {
        downloader.fetchFlowerDetails(flowerId: flowerId, success: success, failure: failure)
    }
}
