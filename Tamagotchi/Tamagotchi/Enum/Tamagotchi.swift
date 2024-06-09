//
//  Tamagotchi.swift
//  Tamagotchi
//
//  Created by 아라 on 6/9/24.
//

import UIKit

enum Tamagotchi: String, CaseIterable {
    case none = "준비중이에요"
    case thorn = "따끔따끔 다마고치"
    case float = "방실방실 다마고치"
    case twinkle = "반짝반짝 다마고치"
    
    var index: Int? {
        return Tamagotchi.allCases.firstIndex(of: self)
    }
    
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
    
    var tamagoInfo: String {
        switch self {
        case .thorn: """
                     "저는 따끔따끔 다마고치입니다-_-^
                     키는 가시 포함 120km, 몸무게는 135톤이에요
                     성격은 생김새와 다르게 보드라운 편임니다
                     포옹을 좋아해요~!
                     따끔따끔
                     """
        case .float: """
                     저는 방실방실 다마고치입니다^_^
                     키는 100km, 몸무게는 150톤이에요
                     성격은 화끈하고 날라다님니다~!
                     열심히 잘 먹고 잘 클 자신은 있습니당
                     방실방실
                     """
        case .twinkle: """
                       저는 반짝반짝 다마고치입니다*_*
                       키는 87km, 몸무게는 160톤이에요
                       성격은 밝고 친화력 짱짱임니다~!
                       누구든 친해질 자신 있어요ㅋ
                       반짝반짝
                       """
        case .none: ""
        }
    }
}
