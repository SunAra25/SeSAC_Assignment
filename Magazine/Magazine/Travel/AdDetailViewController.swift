//
//  AdDetailViewController.swift
//  Magazine
//
//  Created by 아라 on 5/29/24.
//

import UIKit

class AdDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backbutton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissPresentView))
        backbutton.tintColor = .black
        
        navigationItem.leftBarButtonItem = backbutton

        navigationItem.title = "관광지 화면"
    }
    
    @objc func dismissPresentView() {
        dismiss(animated: true)
    }
}
