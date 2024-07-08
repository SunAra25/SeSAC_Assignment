//
//  TodoTableViewCell.swift
//  Reminder
//
//  Created by 아라 on 7/2/24.
//

import UIKit
import SnapKit

final class TodoTableViewCell: BaseTableViewCell {
    let radiouButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "circle")
        config.baseForegroundColor = .systemGray2
        button.configuration = config
        return button
    }()
    private let priorityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .systemBlue
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    private let pinImageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .systemYellow
        view.image = UIImage(systemName: "pin.fill")
        return view
    }()
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .systemGray2
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .systemGray2
        return label
    }()
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .systemBlue
        return label
    }()
    
    override func prepareForReuse() {
        tagLabel.text = nil
    }
    
    override func setLayout() {
        [radiouButton, priorityLabel, titleLabel, pinImageView, contentLabel, dateLabel, tagLabel].forEach {
            contentView.addSubview($0)
        }
        
        radiouButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
            make.width.height.equalTo(28)
        }
        
        priorityLabel.snp.makeConstraints { make in
            make.centerY.equalTo(radiouButton)
            make.leading.equalTo(radiouButton.snp.trailing).offset(11)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(radiouButton)
            make.leading.equalTo(priorityLabel.snp.trailing).offset(4)
        }
        
        pinImageView.snp.makeConstraints { make in
            make.centerY.equalTo(radiouButton)
            make.leading.equalTo(titleLabel.snp.trailing).offset(4)
            make.size.equalTo(12)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(radiouButton.snp.trailing).offset(11)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(4)
            make.leading.equalTo(radiouButton.snp.trailing).offset(11)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel)
            make.leading.equalTo(dateLabel.snp.trailing).offset(4)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    func configureCell(_ data: TodoTable) {
        titleLabel.text = data.title
        
        pinImageView.isHidden = !data.isPin
        
        if let data = data.priority {
            guard let priority = Priority(title: data) else { return }
            priorityLabel.text = priority.degree
            
            titleLabel.snp.remakeConstraints { make in
                make.centerY.equalTo(radiouButton)
                make.leading.equalTo(priorityLabel.snp.trailing).offset(4)
            }
        } else {
            titleLabel.snp.remakeConstraints { make in
                make.centerY.equalTo(radiouButton)
                make.leading.equalTo(radiouButton.snp.trailing).offset(11)
            }
        }
        
        contentLabel.text = data.content
        contentLabel.isHidden = data.content == nil
        
        dateLabel.text = data.deadline?.toString()
        dateLabel.isHidden = data.deadline == nil
        
        if contentLabel.isHidden {
            dateLabel.snp.remakeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(4)
                make.leading.equalTo(radiouButton.snp.trailing).offset(11)
                make.bottom.equalToSuperview().inset(8)
            }
        } else {
            dateLabel.snp.remakeConstraints { make in
                make.top.equalTo(contentLabel.snp.bottom).offset(4)
                make.leading.equalTo(radiouButton.snp.trailing).offset(11)
                make.bottom.equalToSuperview().inset(8)
            }
        }
        
        radiouButton.configuration?.image = UIImage(systemName: data.isDone ? "circle.inset.filled" : "circle")
        
        guard let tag = data.main.first?.title else { return }
        tagLabel.text = "#\(tag)"
        
        if dateLabel.isHidden {
            tagLabel.snp.remakeConstraints { make in
                make.top.equalTo(dateLabel)
                make.leading.equalTo(radiouButton.snp.trailing).offset(11)
                make.bottom.equalToSuperview().inset(8)
            }
        } else {
            tagLabel.snp.remakeConstraints { make in
                make.top.equalTo(dateLabel)
                make.leading.equalTo(dateLabel.snp.trailing).offset(4)
                make.bottom.equalToSuperview().inset(8)
            }
        }
    }
}
