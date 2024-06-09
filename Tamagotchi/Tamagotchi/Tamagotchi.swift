//
//  Tamagotchi.swift
//  Tamagotchi
//
//  Created by 아라 on 6/9/24.
//

import UIKit

enum Tamagotchi: String {
    case thorn = "따끔따끔 다마고치"
    case float = "방실방실 다마고치"
    case twinkle = "반짝반짝 다마고치"
    case none = "준비중이에요"
    
    var tamagoImage: UIImage {
        switch self {
        case .thorn:
            UIImage._1_6
        case .float:
            UIImage._2_6
        case .twinkle:
            UIImage._3_6
        case .none:
            UIImage.no
        }
    }
}
