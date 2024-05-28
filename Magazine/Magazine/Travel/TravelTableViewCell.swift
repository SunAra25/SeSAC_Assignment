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
    
    static let identifier = "TravelTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    func configureLayout() {
        titleLabel.configureLabel(text: "", color: .darkGray, font: .systemFont(ofSize: 17, weight: .black), alignment: .left)

        descriptionLabel.configureLabel(text: "", color: .systemGray2, font: .boldSystemFont(ofSize: 14), alignment:  .left)
        descriptionLabel.numberOfLines = 0
        
        for view in gradeImage {
            view.image = UIImage(systemName: "star.fill")
        }
        
        etcLabel.configureLabel(text: "", color: .systemGray3, font: .systemFont(ofSize: 12), alignment: .left)
        
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
