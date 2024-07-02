//
//  MemoInputTableViewCell.swift
//  Reminder
//
//  Created by 아라 on 7/2/24.
//

import UIKit
import SnapKit

class MemoInputTableViewCell: BaseTableViewCell {
    private let titleTextField = {
        let field = UITextField()
        field.placeholder = "제목"
        field.font = .systemFont(ofSize: 14)
        field.textAlignment = .left
        field.textColor = .label
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
        view.textContainer.lineBreakMode = .byTruncatingTail
        return view
    }()
    
    override func setLayout() {
        [titleTextField, dividerView, memoTextView].forEach {
            contentView.addSubview($0)
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
