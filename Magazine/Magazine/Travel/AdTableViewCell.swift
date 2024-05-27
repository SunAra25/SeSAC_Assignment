//
//  AdTableViewCell.swift
//  Magazine
//
//  Created by 아라 on 5/27/24.
//

import UIKit

class AdTableViewCell: UITableViewCell {
    @IBOutlet var badgeLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var colorView: UIView!
    
    let backgorundColors: [UIColor] = [
        .systemRed.withAlphaComponent(0.1),
        .systemGreen.withAlphaComponent(0.1),
        .systemBlue.withAlphaComponent(0.1),
        .systemPurple.withAlphaComponent(0.1)]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    func configureLayout() {
        colorView.layer.cornerRadius = 8
        
        badgeLabel.text = "AD"
        badgeLabel.textColor = .black
        badgeLabel.textAlignment = .center
        badgeLabel.font = .systemFont(ofSize: 14)
        badgeLabel.backgroundColor = .systemGray6
        badgeLabel.clipsToBounds = true
        badgeLabel.layer.cornerRadius = 8
        
        messageLabel.textColor = .black
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 16, weight: .black)
        messageLabel.numberOfLines = 0
    }
    
    func configureCell(data: Travel) {
        let index = Int.random(in: 0...100)
        colorView.backgroundColor = backgorundColors[index % 4]
        messageLabel.text = data.title
    }
}
