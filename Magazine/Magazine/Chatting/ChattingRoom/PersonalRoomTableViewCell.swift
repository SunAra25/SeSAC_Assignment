//
//  ChattingRoomTableViewCell.swift
//  Magazine
//
//  Created by 아라 on 6/2/24.
//

import UIKit

class PersonalRoomTableViewCell: UITableViewCell {
    static let identifier = "PersonalRoomTableViewCell"
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var lastMessageLabel: UILabel!
    @IBOutlet var lastDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func configure() {
        profileImageView.layer.cornerRadius = 28
        profileImageView.backgroundColor = .black
        nameLabel.font = .boldSystemFont(ofSize: 14)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        
        lastMessageLabel.font = .systemFont(ofSize: 12)
        lastMessageLabel.textColor = .darkGray
        lastMessageLabel.textAlignment = .left
        
        lastDateLabel.font = .systemFont(ofSize: 11)
        lastDateLabel.textColor = .darkGray
        lastDateLabel.textAlignment = .right
    }
}
