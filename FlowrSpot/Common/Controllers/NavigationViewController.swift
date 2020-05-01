//
//  NavigationViewController.swift
//  FlowrSpot
//
//  Created by TK on 17/01/2018.
//  Copyright © 2018 PovioLabs. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
}

// MARK: - Private methods
private extension NavigationViewController {
  func setupViews() {
    navigationBar.barTintColor = .white
    navigationBar.titleTextAttributes = [.font: UIFont.custom(type: .bold, size: 17),
                                         .foregroundColor: UIColor.flowrPink]
    navigationBar.setBackgroundImage(UIImage(), for: .top, barMetrics: .default)
    navigationBar.shadowImage = UIImage()
    navigationBar.tintColor = .white
    navigationBar.layer.masksToBounds = false
    
    let backgroundColor = UIColor.white
    navigationBar.barTintColor = backgroundColor
    navigationBar.backgroundColor = backgroundColor
    navigationBar.isTranslucent = false
  }
}
