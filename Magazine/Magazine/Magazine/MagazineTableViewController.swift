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
        
        headerLabel.configureLabel(text: "SeSAC TRAVEL", color: .black, font: .boldSystemFont(ofSize: 16), alignment: .center)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MagazineTableViewCell.identifier, for: indexPath) as! MagazineTableViewCell
        let row = list[indexPath.row]
        
        if let url = URL(string: row.photo_image) {
            cell.photoImageView.kf.setImage(with: url)
        }
        cell.photoImageView.layer.cornerRadius = 12
        cell.photoImageView.contentMode = .scaleAspectFill
        cell.photoImageView.clipsToBounds = true
        
        cell.titleLabel.configureLabel(text: row.title, color: .darkGray, font: .systemFont(ofSize: 18, weight: .heavy), alignment: .left)
        cell.titleLabel.numberOfLines = 0
        
        cell.subTitleLabel.configureLabel(text: row.subtitle, color: .systemGray, font: .systemFont(ofSize: 12, weight: .semibold), alignment: .left)
       
        cell.dateLabel.configureLabel(text: row.dateFormat, color: .systemGray, font: .systemFont(ofSize: 12), alignment: .right)
        
        return cell
    }
}
