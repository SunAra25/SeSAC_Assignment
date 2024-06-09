//
//  UIImage+.swift
//  Tamagotchi
//
//  Created by 아라 on 6/7/24.
//

import UIKit

extension UIImage {
    class var feedingWater: UIImage {
        let config = UIImage.SymbolConfiguration(scale: .medium)
        return UIImage(systemName: "drop.circle", withConfiguration: config)!
    }
    class var feedingFood: UIImage {
        let config = UIImage.SymbolConfiguration(scale: .medium)
        return UIImage(systemName: "leaf.circle", withConfiguration: config)!
    }
    class var setting: UIImage { return UIImage(systemName: "person.circle")! }
    class var edit: UIImage { return UIImage(systemName: "pencil")! }
    class var chage: UIImage { return UIImage(systemName: "moon.fil")! }
    class var reset: UIImage { return UIImage(systemName: "arrow.clockwise")! }
}
