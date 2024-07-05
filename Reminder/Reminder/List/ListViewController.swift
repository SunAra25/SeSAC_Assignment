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
    private lazy var list = {
        switch self.category {
        case .today: return self.repository.fetchTodayTodo()
        case .expected: return self.repository.fetchScheduledTodo()
        case .all: return self.repository.fetchAllTodo()
        case .flag: return self.repository.fetchFlaggedTodo()
        case .done: return self.repository.fetchCompletedTodo()
        }
    }() {
        didSet {
            tableView.reloadData()
        }
    }
    private let category: Category
    
    init(_ category: Category) {
        self.category = category
        itemTitleLabel.text = category.rawValue
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "ellipsis.circle")
        button.configuration = config
        button.showsMenuAsPrimaryAction = true
        
        let deadline = UIAction(title: "마감일 순") { [weak self] _ in
            guard let self else { return }
            list = repository.sortDeadline()
        }
        let title = UIAction(title: "제목 순") { [weak self] _ in
            guard let self else { return }
            list = repository.sortTitle()
        }
        let higherPriority = UIAction(title: "우선순위 낮음만") { [weak self] _ in
            guard let self else { return }
            list = repository.filterPriority()
        }
        let menu = UIMenu(title: "", children: [title, deadline, higherPriority])
        button.menu = menu
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
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
    
    @objc func moreBtnDidTap() {
        
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
        cell.radiouButton.tag = indexPath.row
        cell.radiouButton.addTarget(self, action: #selector(radioBtnDidTap), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        
        let nextVC = DetailViewController(data)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let pin = UIContextualAction(style: .normal, title: "") { [weak self] (_, _, success: @escaping (Bool) -> Void) in
            guard let self else { return }
            let data = list[indexPath.row]
            repository.itemPinned(data)
            tableView.reloadData()
            success(true)
        }
        let flag = UIContextualAction(style: .normal, title: "") { [weak self] (_, _, success: @escaping (Bool) -> Void) in
            guard let self else { return }
            let data = list[indexPath.row]
            repository.itemFlagged(data)
            tableView.reloadData()
            success(true)
        }
        let delete = UIContextualAction(style: .normal, title: "") { [weak self] (_, _, success: @escaping (Bool) -> Void) in
            guard let self else { return }
            let data = list[indexPath.row]
            repository.deleteItem(data)
            tableView.reloadData()
            success(true)
        }
        
        delete.backgroundColor = .systemRed
        delete.image = UIImage(systemName: "trash.fill")
        
        flag.backgroundColor = .systemOrange
        flag.image = UIImage(systemName: "flag.fill")
        
        pin.backgroundColor = .systemYellow
        pin.image = UIImage(systemName: "pin.fill")
        
        return UISwipeActionsConfiguration(actions: [delete, flag, pin])
    }
    
    @objc func radioBtnDidTap(_ sender: UIButton) {
        let index = sender.tag
        let data = list[index]
        
        repository.itemCompleted(data)
        tableView.reloadData()
    }
}
