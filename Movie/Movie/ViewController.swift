//
//  ViewController.swift
//  Movie
//
//  Created by 아라 on 6/4/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonDidTap(_ sender: UIButton) {
        let vc = SignViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}

