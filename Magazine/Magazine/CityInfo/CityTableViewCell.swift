//
//  CityTableViewCell.swift
//  Magazine
//
//  Created by 아라 on 5/29/24.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    static let identifier = "CityTableViewCell"
    
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var shadowBackgroundView: UIView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var explainLabel: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
