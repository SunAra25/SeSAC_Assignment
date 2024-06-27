//
//  SearchTableViewCell.swift
//  Media
//
//  Created by 아라 on 6/27/24.
//

import UIKit
import SnapKit

class SearchTableViewCell: UITableViewCell {
    static let identifier = "SearchTableViewCell"
    
    let titleLabel = UILabel()
    let deleteButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureView() {
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "xmark")
        config.baseForegroundColor = .black
        deleteButton.configuration = config
    }
    
    func configureLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(deleteButton)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
        }
    }
}
