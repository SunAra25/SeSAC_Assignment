//
//  BaseViewController.swift
//  Reminder
//
//  Created by 아라 on 7/2/24.
//

import UIKit
import RealmSwift

class BaseViewController: UIViewController {
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        setNavigation()
        setHierarchy()
        setConstraints()
    }
    
    func setNavigation() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    func setHierarchy() {}
    
    func setConstraints() {}
}
