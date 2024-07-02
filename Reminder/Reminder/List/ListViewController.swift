//
//  ListViewController.swift
//  Reminder
//
//  Created by 아라 on 7/2/24.
//

import UIKit
import SnapKit
import RealmSwift

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
    private lazy var list: Results<TodoTable> = {
        return realm.objects(TodoTable.self).sorted(byKeyPath: "deadline", ascending: true)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.dismissAddViewNotification(_:)),
            name: NSNotification.Name("DismissAddView"),
            object: nil
        )
    }
    
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
        let nextVC = AddViewController()
        
        present(nextVC, animated: true)
    }
    
    @objc func dismissAddViewNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifer, for: indexPath) as? TodoTableViewCell else { return TodoTableViewCell() }
        cell.configureCell(list[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        
        try! realm.write {
            data.isDone.toggle()
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
