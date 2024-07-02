//
//  ListViewController.swift
//  Reminder
//
//  Created by 아라 on 7/2/24.
//

import UIKit
import SnapKit

final class ListViewController: BaseViewController {
    private let itemTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "전체"
        label.font = .boldSystemFont(ofSize: 32)
        label.textAlignment = .left
        label.textColor = .systemBlue
        return label
    }()
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifer)
        return view
    }()
    
    override func setNavigation() {
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(leftBarBtnDidTap))
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    override func setHierarchy() {
        view.addSubview(itemTitleLabel)
        view.addSubview(tableView)
    }
    
    override func setConstraints() {
        itemTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(itemTitleLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func leftBarBtnDidTap() {
        // TODO: 등록화면으로 전환
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifer, for: indexPath) as? TodoTableViewCell else { return TodoTableViewCell() }
        
        return cell
    }
}
