//
//  RestaurantTableViewController.swift
//  Magazine
//
//  Created by 아라 on 5/25/24.
//

import UIKit
import Kingfisher

class RestaurantTableViewController: UITableViewController {
    let list = RestaurantList().restaurantArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 140
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        let row = list[indexPath.row]
        
        guard let imageURL = URL(string: row.image) else { return cell }
        cell.thumbnailImage.kf.setImage(with: imageURL)
        cell.thumbnailImage.layer.cornerRadius = 10
        cell.thumbnailImage.clipsToBounds = true
        cell.thumbnailImage.contentMode = .scaleAspectFill
        
        setLabel(cell.nameLabel, text: row.name, color: .black, font: .boldSystemFont(ofSize: 16))
        
        setLabel(cell.categoryLabel, text: row.category, color: .black, font: .systemFont(ofSize: 12))
        setCapsule(cell.categoryLabel)
        
        setLabel(cell.addressLabel, text: row.address, color: .darkGray, font: .systemFont(ofSize: 14))
        cell.addressLabel.numberOfLines = 0
        
        setButton(cell.phoneButton, title: row.phoneNumber)
        
        setLabel(cell.priceLabel, text: "가격 : \(row.price)", color: .darkGray, font: .systemFont(ofSize: 12))
        
        return cell
    }
    
    func setLabel(_ label: UILabel, text: String, color: UIColor?, font: UIFont?) {
        label.text = text
        label.textColor = color
        label.font = font
    }
    
    func setCapsule(_ label: UILabel) {
        label.textAlignment = .center
        label.backgroundColor = .systemGray6
        label.layer.cornerRadius = 10
        label.layer.borderColor = UIColor.darkGray.cgColor
        label.layer.borderWidth = 2
        label.clipsToBounds = true
    }
    
    func setButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.tintColor = .darkGray
    }
}
