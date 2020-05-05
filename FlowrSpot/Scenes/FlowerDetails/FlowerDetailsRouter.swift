//
//  FlowerDetailsRouter.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 01/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import UIKit

protocol FlowerDetailsRoutingLogic {
    func navigateToNewSighting(flower: Flower)
    func navigateToSightingDetails(sighting: Sighting)
    func navigateToAlert(title: String, message: String, handler: (() -> Void)?)
}

protocol FlowerDetailsRouterDelegate: class {
    
}

class FlowerDetailsRouter {
    weak var viewController: FlowerDetailsViewController?
    weak var delegate: FlowerDetailsRouterDelegate?
}

// MARK: - Routing Logic
extension FlowerDetailsRouter: FlowerDetailsRoutingLogic {
    
    func navigateToNewSighting(flower: Flower) {
        // TODO: - Implement me
        let newSightingViewController = NewSightingViewController()
        let navigationController = NavigationViewController(rootViewController: newSightingViewController)
        viewController?.present(navigationController, animated: true, completion: nil)
    }
    
    func navigateToSightingDetails(sighting: Sighting) {
        // TODO: - Implement me
        let sightingDetailsViewController = SightingDetailsViewController(sighting: sighting)
        viewController?.navigationController?.pushViewController(sightingDetailsViewController, animated: true)
    }
    
    func navigateToAlert(title: String, message: String, handler: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "general_ok".localized(), style: .cancel, handler: { _ in handler?() }))
        viewController?.present(alert, animated: true, completion: nil)
    }
}
