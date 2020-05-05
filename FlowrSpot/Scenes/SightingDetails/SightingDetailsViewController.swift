//
//  SightingDetailsViewController.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 05/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import UIKit

class SightingDetailsViewController: UIViewController {
    
    private let sighting: Sighting
    
    init(sighting: Sighting) {
        self.sighting = sighting
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
}

extension SightingDetailsViewController {
    func setupViews() {
        self.view.backgroundColor = UIColor.white
        navigationItem.title = sighting.name
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: AssetCatalog.plIconBack.image.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(backBarButtonPressed))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.flowrGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: AssetCatalog.plIconDots.image.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(barButtonPressed))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.flowrGray
    }
        
    @objc func backBarButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func barButtonPressed() {
    }
}
