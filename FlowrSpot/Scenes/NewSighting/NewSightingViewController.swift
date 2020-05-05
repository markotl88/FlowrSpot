//
//  NewSightingViewController.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 05/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import UIKit

class NewSightingViewController: UIViewController {
    
    init() {
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

extension NewSightingViewController {
    private func setupViews() {
        self.view.backgroundColor = UIColor.white
        
        navigationItem.title = "add_sighting_title".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plIconClose")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(closeButtonPressed))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.flowrGray

    }
    
    @objc func closeButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
}
