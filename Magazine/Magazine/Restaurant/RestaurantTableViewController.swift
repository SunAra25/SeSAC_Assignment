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
        
        cell.nameLabel.text = row.name
        cell.nameLabel.textColor = .black
        cell.nameLabel.textAlignment = .left
        cell.nameLabel.font = .boldSystemFont(ofSize: 16)
        
        cell.categoryLabel.text = row.category
        cell.categoryLabel.textColor = .black
        cell.categoryLabel.textAlignment = .center
        cell.categoryLabel.font = .systemFont(ofSize: 12)
        cell.categoryLabel.backgroundColor = .systemGray6
        cell.categoryLabel.layer.cornerRadius = 10
        cell.categoryLabel.layer.borderColor = UIColor.darkGray.cgColor
        cell.categoryLabel.layer.borderWidth = 2
        cell.categoryLabel.clipsToBounds = true
        
        cell.addressLabel.text = row.address
        cell.addressLabel.textColor = .darkGray
        cell.addressLabel.textAlignment = .left
        cell.addressLabel.font = .systemFont(ofSize: 14)
        cell.addressLabel.numberOfLines = 0
        
        cell.phoneButton.setTitle(row.phoneNumber, for: .normal)
        cell.phoneButton.setTitleColor(.darkGray, for: .normal)
        cell.phoneButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        cell.phoneButton.tintColor = .darkGray
        
        cell.priceLabel.text = "가격 : \(row.price)"
        cell.priceLabel.textColor = .darkGray
        cell.priceLabel.textAlignment = .left
        cell.priceLabel.font = .systemFont(ofSize: 12)
        
        return cell
    }
}
