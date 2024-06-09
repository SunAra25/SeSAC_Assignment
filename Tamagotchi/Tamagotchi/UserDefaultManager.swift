//
//  UserDefault+.swift
//  Tamagotchi
//
//  Created by 아라 on 6/9/24.
//

import Foundation

class UserDefaultsManager {
    var nickname: String {
        get {
            UserDefaults.standard.string(forKey: "nickname") ?? "대장님"
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "nickname")
        }
    }
}
