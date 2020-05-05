//
//  AssetCatalog.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 05/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import UIKit

enum AssetCatalog: String {
    
    // MARK: - Icons
    case plIconBack
    case plIconClose
    case plIconComment
    case plIconCommentRed
    case plIconDots
    case plIconFavorites
    case plIconHero
    case plIconImage
    case plIconLike
    case plIconLocation
    case plIconNewSighting
    case plIconSearch
    case plIconSighting
    case plIconStar
    case plIconUser

    var image: UIImage {
        guard let image = UIImage(named: self.rawValue, in: Bundle.main, compatibleWith: nil) else {
            fatalError("No image asset with name: \(self.rawValue) in FlowrSpot")
        }
        return image
    }
}
