//
//  BaseViewController.swift
//  Tamagotchi
//
//  Created by 아라 on 6/7/24.
//

import UIKit

class BaseViewController: UIViewController {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        view.backgroundColor = .back
    }
}
