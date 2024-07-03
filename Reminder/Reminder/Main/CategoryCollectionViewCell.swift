//
//  CategoryCollectionViewCell.swift
//  Reminder
//
//  Created by 아라 on 7/3/24.
//

import UIKit
import SnapKit

final class CategoryCollectionViewCell: BaseCollectionViewCell {
    private let backView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 12
        return view
    }()
    private let imageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 24
        return view
    }()
    private let countLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .label
        label.textAlignment = .right
        return label
    }()
    private let categoryLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .systemGray
        label.textAlignment = .right
        return label
    }()
    
    override func setLayout() {
        contentView.addSubview(backView)
        [imageView, countLabel, categoryLabel].forEach {
            backView.addSubview($0)
        }
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(12)
            make.size.equalTo(48)
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(12)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(12)
        }
    }
    
    func configureCell(_ data: Category) {
        categoryLabel.text = data.rawValue
        imageView.image = data.iconImage
        imageView.tintColor = data.backgroundColor
    }
}
