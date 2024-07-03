//
//  BaseCollectionViewCell.swift
//  Reminder
//
//  Created by 아라 on 7/3/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    static var identifer: String {
       return String(describing: self)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {}
    
    func configureCell<T>(_ data: T) {}
}
