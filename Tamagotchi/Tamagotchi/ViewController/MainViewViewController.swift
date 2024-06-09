//
//  MainViewController.swift
//  Tamagotchi
//
//  Created by 아라 on 6/9/24.
//

import UIKit
import SnapKit

class MainViewController: BaseNavigationViewController {
    let userDefaults = UserDefaultsManager()
    var tamagotchi: Tamagotchi?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setHierarchy()
        setConstraints()
    }
    
    override func configureView() {
        super.configureView()
        
        setRightBarButtonItemAsSetting()
        title = "\(userDefaults.nickname)의 다마고치"
    }
    
    func setHierarchy() {
        
    }
    
    func setConstraints() {
        
    }
}
