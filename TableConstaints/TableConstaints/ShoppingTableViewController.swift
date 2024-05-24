//
//  ShoppingTableViewController.swift
//  TableConstaints
//
//  Created by 아라 on 5/23/24.
//

import UIKit

class ShoppingTableViewController: UITableViewController {
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        inputTextField.backgroundColor = .lightGray.withAlphaComponent(0.1)
        inputTextField.layer.cornerRadius = 12
        inputTextField.placeholder = "무엇을 구매하실 건가요?"
        inputTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        inputTextField.leftViewMode = .always
        
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.layer.cornerRadius = 10
        addButton.backgroundColor = .lightGray.withAlphaComponent(0.3)
        
    }
    
}
