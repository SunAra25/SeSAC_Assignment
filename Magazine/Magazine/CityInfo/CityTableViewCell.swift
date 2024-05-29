//
//  CityTableViewCell.swift
//  Magazine
//
//  Created by 아라 on 5/29/24.
//

import UIKit
import Kingfisher

class CityTableViewCell: UITableViewCell {
    static let identifier = "CityTableViewCell"
    
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var shadowBackgroundView: UIView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var explainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setConfigure()
    }
    
    func setConfigure() {
        cityLabel.textColor = .white
        cityLabel.font = .systemFont(ofSize: 24, weight: .heavy)
        cityLabel.textAlignment = .right
        
        explainLabel.textColor = .systemGray5
        explainLabel.font = .systemFont(ofSize: 14)
        explainLabel.textAlignment = .left
        
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.clipsToBounds = true
        cityImageView.layer.cornerRadius = 15
        
        shadowBackgroundView.backgroundColor = .black.withAlphaComponent(0.5)
        shadowBackgroundView.clipsToBounds = true
    }
    
    func configureCell(_ data: City) {
        cityLabel.text = data.name
        explainLabel.text = data.city_explain
        cityImageView.kf.setImage(with: URL(string: data.city_image)!)
    }
}
