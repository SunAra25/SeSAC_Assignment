//
//  ShoppingTableViewController.swift
//  TableConstaints
//
//  Created by 아라 on 5/23/24.
//

import UIKit

struct Shopping {
    var isComplete: Bool
    let title: String
    var isLike: Bool
}

class ShoppingTableViewController: UITableViewController {
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    var list = [
    Shopping(isComplete: true, title: "그립톡 구매하기", isLike: true),
    Shopping(isComplete: false, title: "사이다 구매", isLike: false),
    Shopping(isComplete: false, title: "아애피드 케이스 최저가 알아보기", isLike: true),
    Shopping(isComplete: false, title: "양말", isLike: true)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        inputTextField.backgroundColor = .lightGray.withAlphaComponent(0.1)
        inputTextField.layer.cornerRadius = 12
        inputTextField.placeholder = "무엇을 구매하실 건가요?"
        inputTextField.font = .systemFont(ofSize: 12)
        inputTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        inputTextField.leftViewMode = .always
        
        addButton.setTitle("추가", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 12)
        addButton.setTitleColor(.black, for: .normal)
        addButton.layer.cornerRadius = 10
        addButton.backgroundColor = .lightGray.withAlphaComponent(0.3)
        
        inputTextField.addTarget(self, action: #selector(addItem), for: .editingDidEndOnExit)
        addButton.addTarget(self, action: #selector(addItem), for: .touchUpInside)
        
        tableView.rowHeight = 44
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        let row = list[indexPath.row]
        
        cell.baseView.backgroundColor = .lightGray.withAlphaComponent(0.1)
        cell.baseView.layer.cornerRadius = 12
        
        let checkImage = row.isComplete ? "checkmark.square.fill" : "checkmark.square"
        cell.checkButton.setImage(UIImage(systemName: checkImage), for: .normal)
        cell.checkButton.tintColor = .black
        
        cell.titleLabel.text = row.title
        cell.titleLabel.font = .systemFont(ofSize: 12)
        
        let starImage = row.isLike ? "star.fill" : "star"
        cell.starButton.setImage(UIImage(systemName: starImage), for: .normal)
        cell.starButton.tintColor = .black
        
        return cell
    }
    
    @objc func addItem(sender: Any) {
        guard let item = inputTextField.text, !item.isEmpty else { return }
        inputTextField.text = ""
        
        list.append(Shopping(isComplete: false, title: item, isLike: false))
        
        tableView.reloadData()
    }
}
