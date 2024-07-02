//
//  MemoInputTableViewCell.swift
//  Reminder
//
//  Created by 아라 on 7/2/24.
//

import UIKit
import SnapKit

final class MemoInputTableViewCell: BaseTableViewCell {
    private let backView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.backgroundColor = .systemGray4
        return view
    }()
    private let titleTextField = {
        let field = UITextField()
        field.placeholder = "제목"
        field.font = .systemFont(ofSize: 14)
        field.textAlignment = .left
        field.textColor = .label
        field.tintColor = .label
        return field
    }()
    private let dividerView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        return view
    }()
    private let memoTextView = {
        let view = UITextView()
        view.text = "메모"
        view.font = .systemFont(ofSize: 14)
        view.textAlignment = .left
        view.textColor = .systemGray2
        view.tintColor = .label
        view.textContainer.lineBreakMode = .byTruncatingTail
        view.backgroundColor = .clear
        return view
    }()
    
    override func setLayout() {
        contentView.addSubview(backView)
        
        [titleTextField, dividerView, memoTextView].forEach {
            backView.addSubview($0)
        }
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview().inset(12)
        }
    }
}
