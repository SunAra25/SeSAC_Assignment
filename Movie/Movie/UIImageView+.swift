//
//  UIImageView+.swift
//  Movie
//
//  Created by 아라 on 6/5/24.
//

import UIKit

extension UIImageView {
    func setPoster() {
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 12
    }
}
