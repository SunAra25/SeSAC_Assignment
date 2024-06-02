//
//  MyChattingTableViewCell.swift
//  Magazine
//
//  Created by 아라 on 6/2/24.
//

import UIKit

class MyChattingTableViewCell: UITableViewCell {
    static let identifier = "MyChattingTableViewCell"
    
    @IBOutlet var messageView: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    func configure() {
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
        timeLabel.textAlignment = .right
    }
    
    func configureCell(_ data: Chat) {
        messageLabel.text = data.message
        
        timeLabel.text = data.chatTime
    }
}
