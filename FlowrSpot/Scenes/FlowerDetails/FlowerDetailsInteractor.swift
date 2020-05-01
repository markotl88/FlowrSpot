//
//  FlowerDetailsInteractor.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 01/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import Foundation

protocol FlowerDetailsBusinessLogic {
    func fetchFlower()
}

class FlowerDetailsInteractor {
    var flowerId: Int?
    var presenter: FlowerDetailsPresentationLogic?
    var getFlowerDetailsWorker = GetFlowerDetailsWorker()
}

// MARK: - Business Logic
extension FlowerDetailsInteractor: FlowerDetailsBusinessLogic {
    func fetchFlower() {
        
        guard let flowerId = flowerId else { return }
        
        getFlowerDetailsWorker.execute(flowerId: flowerId, success: { (flower) in
            self.presenter?.presentFlower(flower)
        }, failure: { error in
            self.presenter?.presentFlowerError(error)
        })
    }
}
