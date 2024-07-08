//
//  OtherInputTableViewCell.swift
//  Reminder
//
//  Created by 아라 on 7/2/24.
//

import UIKit
import SnapKit

final class OtherInputTableViewCell: BaseTableViewCell {
    private let backView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.backgroundColor = .systemGray4
        return view
    }()
    private let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    private let dataLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        label.textColor = .systemGray
        return label
    }()
    private let selectedImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    private let nextImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = .systemGray2
        return view
    }()
    
    override func setLayout() {
        contentView.addSubview(backView)
        
        [titleLabel, dataLabel, selectedImageView, nextImageView].forEach {
            backView.addSubview($0)
        }
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview().inset(16)
        }
        
        nextImageView.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview().inset(16)
            make.width.equalTo(16)
        }
        
        dataLabel.snp.makeConstraints { make in
            make.trailing.equalTo(nextImageView.snp.leading)
            make.centerY.equalTo(titleLabel)
        }
        
        selectedImageView.snp.makeConstraints { make in
            make.trailing.equalTo(nextImageView.snp.leading).offset(-8)
            make.verticalEdges.equalToSuperview().inset(8)
            make.width.equalTo(selectedImageView.snp.height)
        }
    }
    
    func configureCell(_ data: (title: String, deadline: Date?, tag: TagTable?, priority: String?, image: UIImage?)) {
        titleLabel.text = data.title
        dataLabel.text = data.deadline == nil ? data.tag == nil ? data.priority : data.tag?.title : data.deadline?.toString()
        selectedImageView.image = data.image
    }
}
