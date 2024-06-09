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
            UserDefaults.standard.string(forKey: "nickname") ?? "대장"
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "nickname")
        }
    }
    
    var level: Int {
        get {
            let level = UserDefaults.standard.integer(forKey: "level")
            return level == 0 ? 1 : level
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "level")
        }
    }
    
    var food: Int {
        get {
            UserDefaults.standard.integer(forKey: "food")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "food")
        }
    }
    
    var water: Int {
        get {
            UserDefaults.standard.integer(forKey: "water")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "water")
        }
    }
}
