//
//  UserDefault+.swift
//  Tamagotchi
//
//  Created by 아라 on 6/9/24.
//

import Foundation

class UserDefaultsManager {
    private let userDefaults = UserDefaults.standard
    
    var myTamagotchi: Tamagotchi? {
        get {
            guard let rawValue = userDefaults.object(forKey: "tamagotchi") as? Int else { return nil }
            return Tamagotchi(rawValue: rawValue)
        }
        
        set {
            userDefaults.setValue(newValue?.rawValue, forKey: "tamagotchi")
        }
    }
    
    var nickname: String {
        get {
            userDefaults.string(forKey: "nickname") ?? "대장"
        }
        
        set {
            userDefaults.set(newValue, forKey: "nickname")
        }
    }
    
    var level: Int {
        get {
            let level = userDefaults.integer(forKey: "level")
            return level == 0 ? 1 : level
        }
        
        set {
            userDefaults.set(newValue, forKey: "level")
        }
    }
    
    var food: Int {
        get {
            userDefaults.integer(forKey: "food")
        }
        
        set {
            userDefaults.set(newValue, forKey: "food")
        }
    }
    
    var water: Int {
        get {
            userDefaults.integer(forKey: "water")
        }
        
        set {
            userDefaults.set(newValue, forKey: "water")
        }
    }
}
