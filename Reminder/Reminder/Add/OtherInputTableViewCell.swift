//
//  OtherInputTableViewCell.swift
//  Reminder
//
//  Created by 아라 on 7/2/24.
//

import UIKit
import SnapKit

class OtherInputTableViewCell: BaseTableViewCell {
    private let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    private let nextImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = .systemGray3
        return view
    }()
    
    override func setLayout() {
        [titleLabel, nextImageView].forEach {
            contentView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview().offset(16)
        }
        
        nextImageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview().offset(16)
            make.size.equalTo(18)
        }
    }
}
