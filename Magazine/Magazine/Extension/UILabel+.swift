//
//  UILabel+.swift
//  Magazine
//
//  Created by 아라 on 5/28/24.
//

import UIKit

extension UILabel {
    func configureLabel(text: String, color: UIColor?, font: UIFont?, alignment: NSTextAlignment) {
        self.text = text
        self.textColor = color
        self.textAlignment = alignment
        self.font = font
    }
}
