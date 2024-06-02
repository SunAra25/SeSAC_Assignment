//
//  ChattingTableViewCell.swift
//  Magazine
//
//  Created by 아라 on 6/2/24.
//

import UIKit

class MemberChattingTableViewCell: UITableViewCell {
    static let identifier = "MemberChattingTableViewCell"
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageView: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    func configure() {
        profileImageView.layer.cornerRadius = 28
        profileImageView.layer.borderWidth = 0.2
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        
        nameLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        
        messageView.backgroundColor = .white
        messageView.layer.cornerRadius = 12
        messageView.layer.borderWidth = 1
        messageView.layer.borderColor = UIColor.gray.cgColor
        
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.textColor = .black
        messageLabel.textAlignment = .left
        messageLabel.numberOfLines = 0
        
        timeLabel.font = .systemFont(ofSize: 12)
        timeLabel.textColor = .darkGray
        timeLabel.textAlignment = .left
    }
    
    func configureCell(_ data: Chat) {
        let user = data.user
        profileImageView.image = UIImage(named: user.profileImage)
        
        nameLabel.text = user.rawValue
        
        messageLabel.text = data.message
        
        timeLabel.text = data.chatTime
    }
}
