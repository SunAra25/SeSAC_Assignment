//
//  OtherInputViewController.swift
//  Reminder
//
//  Created by 아라 on 7/3/24.
//

import UIKit
import SnapKit

final class OtherInputViewController: BaseViewController {
    private let deadlineView = DeadlineView()
    private let tagView = TagView()
    private let priorityView = PriorityView()
    
    private var currentInput: Input?
    private var tagList: [TagTable] = []
    private var selectedTag: TagTable?
    var selectedDelegate: SelectedDataDelegate?
    
    init(_ num: Int) {
        super.init(nibName: nil, bundle: nil)
        guard let input = Input(rawValue: num) else { return }
        currentInput = input
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = currentInput?.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let tagView = view as? TagView else { return }
        tagList = Array(repository.fetchTags())
        tagView.tableView.delegate = self
        tagView.tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(sendUpdateNotification), name: NSNotification.Name("UpdateTodoTable"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let currentInput else { return }
        
        switch currentInput {
        case .deadline:
            guard let view = view as? DeadlineView else { return }
            let value = view.selectedDate
            selectedDelegate?.sendData(currentInput, value: value)
        case .tag:
            guard let view = view as? TagView, let text = view.textField.text else { return }
            var value: TagTable?
            if selectedTag == nil {
                value = TagTable(title: text)
                repository.createTag(value)
            } else {
                value = selectedTag
            }
            selectedDelegate?.sendData(currentInput, value: value)
        case .priority:
            guard let view = view as? PriorityView else { return }
            let value = view.priority?.title
            selectedDelegate?.sendData(currentInput, value: value)
        }
    }
    
    @objc func sendUpdateNotification() {
        tagList = Array(repository.fetchTags())
    }
}

extension OtherInputViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = tagList[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard view is TagView else { return }
        selectedTag = tagList[indexPath.row]
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "") { [weak self] (_, _, success: @escaping (Bool) -> Void) in
            guard let self else { return }
            let data = tagList[indexPath.row]
            repository.deleteTag(data)
            tableView.reloadData()
            success(true)
        }
        
        delete.backgroundColor = .systemRed
        delete.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

enum Input: Int {
    case deadline = 0
    case tag
    case priority
    
    var view: UIView {
        switch self {
        case .deadline: DeadlineView()
        case .tag: TagView()
        case .priority: PriorityView()
        }
    }
}

