//
//  TravelTableViewCell.swift
//  Magazine
//
//  Created by 아라 on 5/27/24.
//

import UIKit
import Kingfisher

class TravelTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var gradeImage: [UIImageView]!
    @IBOutlet var etcLabel: UILabel!
    @IBOutlet var placeImageView: UIImageView!
    @IBOutlet var saveButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    func configureLayout() {
        titleLabel.textColor = .darkGray
        titleLabel.font = .systemFont(ofSize: 17, weight: .black)
        titleLabel.textAlignment = .left
        
        descriptionLabel.textColor = .systemGray2
        descriptionLabel.font = .boldSystemFont(ofSize: 14)
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        
        for view in gradeImage {
            view.image = UIImage(systemName: "star.fill")
        }
        
        etcLabel.textColor = .systemGray3
        etcLabel.font = .systemFont(ofSize: 12)
        etcLabel.textAlignment = .left
        
        placeImageView.layer.cornerRadius = 12
        placeImageView.contentMode = .scaleAspectFill
        
        saveButton.setTitle("", for: .normal)
        saveButton.tintColor = .white
    }
    
    func configureCell(data: Travel, tag: Int) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        etcLabel.text = "\(data.grade!) ∙ 저장 \(data.saveFormat)"
        placeImageView.kf.setImage(with: URL(string: data.travel_image!)!)
        saveButton.setImage(UIImage(systemName: data.like! ? "heart.fill" : "heart"), for: .normal)
        saveButton.tag = tag
        
        for (index, item) in gradeImage.enumerated() {
            item.tintColor = index >= Int(data.grade!) ? .systemGray5 : .systemYellow
        }
    }
}
