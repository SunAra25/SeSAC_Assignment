//
//  AddViewController.swift
//  Reminder
//
//  Created by 아라 on 7/2/24.
//

import UIKit
import SnapKit

final class AddViewController: BaseViewController {
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
        
        button.addTarget(self, action: #selector(addBtnDidTap), for: .touchUpInside)
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
        view.separatorStyle = .none
        view.delegate = self
        view.dataSource = self
        view.register(MemoInputTableViewCell.self, forCellReuseIdentifier: MemoInputTableViewCell.identifer)
        view.register(OtherInputTableViewCell.self, forCellReuseIdentifier: OtherInputTableViewCell.identifer)
        return view
    }()
    
    private let inputs = ["마감일", "태그"]
    private var memoTitle = ""
    
    override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         NotificationCenter.default.post(name:NSNotification.Name("DismissAddView"), object: nil, userInfo: nil)
    }
    
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
    
    @objc func addBtnDidTap() {
        let data = TodoTable(title: memoTitle)
        
        try! realm.write {
            realm.add(data)
            dismiss(animated: true)
        }
    }
}

extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : inputs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoInputTableViewCell.identifer, for: indexPath) as? MemoInputTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            
            cell.titleTextField.delegate = self
            cell.memoTextView.delegate = self
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherInputTableViewCell.identifer, for: indexPath) as? OtherInputTableViewCell else { return UITableViewCell() }
            let data = inputs[indexPath.row]
            cell.selectionStyle = .none
            cell.configureCell(data)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 180 : 72
    }
}

extension AddViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let input = textField.text else { return }
        addButton.isEnabled = !input.isEmpty
        memoTitle = input
    }
}

extension AddViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .systemGray2 {
            textView.text = ""
            textView.textColor = .label
        }
    }
}