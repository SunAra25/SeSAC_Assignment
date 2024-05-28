//
//  MagazineTableViewController.swift
//  Magazine
//
//  Created by 아라 on 5/25/24.
//

import UIKit
import Kingfisher

class MagazineTableViewController: UITableViewController {
    @IBOutlet var headerLabel: UILabel!
    
    let list = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = "SeSAC TRAVEL"
        headerLabel.textColor = .black
        headerLabel.font = .boldSystemFont(ofSize: 16)
        headerLabel.textAlignment = .center
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MagazineTableViewCell", for: indexPath) as! MagazineTableViewCell
        let row = list[indexPath.row]
        
        if let url = URL(string: row.photo_image) {
            cell.photoImageView.kf.setImage(with: url)
        }
        cell.photoImageView.layer.cornerRadius = 12
        cell.photoImageView.contentMode = .scaleAspectFill
        cell.photoImageView.clipsToBounds = true
        
        cell.titleLabel.text = row.title
        cell.titleLabel.textColor = .darkGray
        cell.titleLabel.textAlignment = .left
        cell.titleLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        cell.titleLabel.numberOfLines = 0
        
        cell.subTitleLabel.text = row.subtitle
        cell.subTitleLabel.textColor = .systemGray
        cell.subTitleLabel.textAlignment = .left
        cell.subTitleLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        
        cell.dateLabel.text = row.dateFormat
        cell.dateLabel.textColor = .systemGray
        cell.dateLabel.textAlignment = .right
        cell.dateLabel.font = .systemFont(ofSize: 12)
        
        return cell
    }
}
