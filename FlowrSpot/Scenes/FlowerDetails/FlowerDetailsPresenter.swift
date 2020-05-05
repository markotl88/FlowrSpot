//
//  FlowerDetailsPresenter.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 01/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import UIKit

protocol FlowerDetailsPresentationLogic {
    func presentSightings(_ sightings: [Sighting])
    func presentFlower(_ flower: Flower)
    func presentFlowerError(_ error: RemoteResourceError)
}

class FlowerDetailsPresenter {
    weak var viewController: FlowerDetailsDisplayLogic?
}

// MARK: - Presentation Logic
extension FlowerDetailsPresenter: FlowerDetailsPresentationLogic {
    func presentFlower(_ flower: Flower) {
        viewController?.displayFlower(flower)
    }
    
    func presentFlowerError(_ error: RemoteResourceError) {
        viewController?.displayError(error)
    }
    
    func presentSightings(_ sightings: [Sighting]) {
        viewController?.displaySightings(sightings)
    }
}
