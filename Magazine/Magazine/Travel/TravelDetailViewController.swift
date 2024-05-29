//
//  TrableDetailViewController.swift
//  Magazine
//
//  Created by 아라 on 5/29/24.
//

import UIKit

class TravelDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backbutton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popToPreviousView))
        backbutton.tintColor = .black
        
        navigationItem.leftBarButtonItem = backbutton

        navigationItem.title = "관광지 화면"
    }
    
    @objc func popToPreviousView() {
        navigationController?.popViewController(animated: true)
    }
}
