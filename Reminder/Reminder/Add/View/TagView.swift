//
//  TagView.swift
//  Reminder
//
//  Created by 아라 on 7/3/24.
//

import UIKit
import SnapKit

class TagView: BaseView {
    lazy var textField = {
        let field = UITextField()
        field.placeholder = "태그를 입력해주세요"
        field.textColor = .label
        field.tintColor = .label
        field.textAlignment = .center
        field.backgroundColor = .systemGray4
        field.layer.cornerRadius = 12
        return field
    }()
    let tableView = {
        let view = UITableView()
        view.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.rowHeight = 60
        return view
    }()
    
    override func setHierarchy() {
        addSubview(textField)
        addSubview(tableView)
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(40)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(48)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
