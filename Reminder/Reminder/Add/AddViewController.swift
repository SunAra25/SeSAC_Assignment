//
//  AddViewController.swift
//  Reminder
//
//  Created by 아라 on 7/2/24.
//

import UIKit
import SnapKit

class AddViewController: BaseViewController {
    private let cancleButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        var attr = AttributedString.init("취소")
        attr.font = UIFont.systemFont(ofSize: 16)
        
        config.attributedTitle = attr
        button.configuration = config
        return button
    }()
    private let addButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        var attr = AttributedString.init("추가")
        attr.font = UIFont.systemFont(ofSize: 16)
        
        config.attributedTitle = attr
        button.configuration = config
        button.isEnabled = false
        return button
    }()
    private let naviTitleLabel = {
        let label = UILabel()
        label.text = "새로운 할 일"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    private lazy var tableView = {
        let view = UITableView()
        view.backgroundColor = .red
        return view
    }()
    
    override func setHierarchy() {
        [cancleButton, addButton, naviTitleLabel, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        naviTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.centerX.equalToSuperview()
        }
        
        cancleButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.centerY.equalTo(naviTitleLabel)
        }
        
        addButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.centerY.equalTo(naviTitleLabel)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(naviTitleLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
    }
}
