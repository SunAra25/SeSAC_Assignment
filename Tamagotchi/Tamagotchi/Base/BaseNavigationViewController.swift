//
//  BaseNavigationViewController.swift
//  Tamagotchi
//
//  Created by 아라 on 6/7/24.
//

import UIKit

class BaseNavigationViewController: BaseViewController {
    override var title: String? {
        didSet {
            navigationItem.title = title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.font!]
    }
    
    func setRightBarButtonItemAsSave() {
        let barButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveUserInfo))
        
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    func setRightBarButtonItemAsSetting() {
        let barButtonItem = UIBarButtonItem(image: .setting, style: .plain, target: self, action: #selector(pushSettingView))
        barButtonItem.tintColor = .font
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func saveUserInfo() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func pushSettingView() {
        
    }
}
