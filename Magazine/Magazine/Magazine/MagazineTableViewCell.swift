//
//  MagazineTableViewCell.swift
//  Magazine
//
//  Created by 아라 on 5/25/24.
//

import UIKit

class MagazineTableViewCell: UITableViewCell {
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    static let identifier = "MagazineTableViewCell"
}
