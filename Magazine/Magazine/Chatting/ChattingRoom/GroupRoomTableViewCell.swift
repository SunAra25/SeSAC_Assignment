//
//  GroupRoomTableViewCell.swift
//  Magazine
//
//  Created by 아라 on 6/2/24.
//

import UIKit

class GroupRoomTableViewCell: UITableViewCell {
    static let identifier = "GroupRoomTableViewCell"
    
    @IBOutlet var profileImageViews: [UIImageView]!
    @IBOutlet var groupNameLabel: UILabel!
    @IBOutlet var memberCountLabel: UILabel!
    @IBOutlet var lastMessageLabel: UILabel!
    @IBOutlet var lastDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    func configure() {
        profileImageViews.forEach {
            $0.layer.cornerRadius = 12
            $0.backgroundColor = .black
        }
        
        groupNameLabel.font = .boldSystemFont(ofSize: 16)
        groupNameLabel.textColor = .black
        groupNameLabel.textAlignment = .left
        
        memberCountLabel.font = .systemFont(ofSize: 15)
        memberCountLabel.textColor = .lightGray
        memberCountLabel.textAlignment = .left
        
        lastMessageLabel.font = .systemFont(ofSize: 14)
        lastMessageLabel.textColor = .darkGray
        lastMessageLabel.textAlignment = .left
        
        lastDateLabel.font = .systemFont(ofSize: 12)
        lastDateLabel.textColor = .darkGray
        lastDateLabel.textAlignment = .right
    }
}
