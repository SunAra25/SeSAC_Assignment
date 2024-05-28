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
    
    static let identifier = "AdTableViewCell"
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
        
        badgeLabel.configureLabel(text: "AD", color: .black, font: .systemFont(ofSize: 14), alignment: .center)
        badgeLabel.backgroundColor = .systemGray6
        badgeLabel.clipsToBounds = true
        badgeLabel.layer.cornerRadius = 8
        
        messageLabel.configureLabel(text: "", color: .black, font: .systemFont(ofSize: 16, weight: .black), alignment: .center)
        messageLabel.numberOfLines = 0
    }
    
    func configureCell(data: Travel) {
        let index = Int.random(in: 0...100)
        colorView.backgroundColor = backgorundColors[index % 4]
        messageLabel.text = data.title
    }
}
