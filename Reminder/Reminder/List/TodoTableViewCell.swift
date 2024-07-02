//
//  TodoTableViewCell.swift
//  Reminder
//
//  Created by 아라 on 7/2/24.
//

import UIKit
import SnapKit

final class TodoTableViewCell: BaseTableViewCell {
    private let radioButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "circle")
        config.baseForegroundColor = .systemGray3
        button.configuration = config
        return button
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .systemGray3
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .systemGray3
        return label
    }()
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .systemBlue
        return label
    }()
    
    override func setLayout() {
        [radioButton, titleLabel, contentLabel, dateLabel, tagLabel].forEach {
            contentView.addSubview($0)
        }
        
        radioButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(8)
            make.width.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(radioButton)
            make.leading.equalTo(radioButton.snp.trailing).offset(6)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel)
            make.leading.equalTo(dateLabel.snp.trailing).offset(4)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    func configureCell(_ data: TodoTable) {
        titleLabel.text = data.title
        contentLabel.text = data.content
        dateLabel.text = data.deadline
        radioButton.configuration?.image = UIImage(systemName: data.isDone ? "circle.fill" : "circle")
        guard let tag = data.tag?.title else { return }
        tagLabel.text = "#\(tag)"
    }
}
