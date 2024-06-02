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
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 28
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        
        nameLabel.font = .boldSystemFont(ofSize: 16)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        
        lastMessageLabel.font = .systemFont(ofSize: 15)
        lastMessageLabel.textColor = .darkGray
        lastMessageLabel.textAlignment = .left
        
        lastDateLabel.font = .systemFont(ofSize: 12)
        lastDateLabel.textColor = .darkGray
        lastDateLabel.textAlignment = .right
    }
    
    func configureCell(_ data: ChatRoom) {
        profileImageView.image = UIImage(named: data.chatroomImage[0])
        
        nameLabel.text = data.chatroomName
        
        if let lastChat = data.chatList.last {
            lastMessageLabel.text = lastChat.message
            lastDateLabel.text = lastChat.chatDate
        }
    }
}
