//
//  AdDetailViewController.swift
//  Magazine
//
//  Created by 아라 on 5/29/24.
//

import UIKit

class AdDetailViewController: UIViewController {
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var backView: UIView!
    
    var content = ""
    var backColor = UIColor.clear
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backbutton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissPresentView))
        backbutton.tintColor = .black
        
        navigationItem.leftBarButtonItem = backbutton

        navigationItem.title = "광고 화면"
        
        view.backgroundColor = .white
        
        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = .center
        configuration(content: content, backgroundColor: backColor)
    }
    
    func configuration(content: String, backgroundColor: UIColor?) {
        backView.backgroundColor = backgroundColor
        contentLabel.text = content
    }
    
    @objc func dismissPresentView() {
        dismiss(animated: true)
    }
}
