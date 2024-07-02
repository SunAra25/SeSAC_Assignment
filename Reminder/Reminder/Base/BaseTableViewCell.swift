//
//  BaseTableViewCell.swift
//  Reminder
//
//  Created by 아라 on 7/2/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    static var identifer: String {
       return String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {}
    
    func configureCell<T>(_ data: T) {}
}
