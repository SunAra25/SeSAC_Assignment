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
            let value = TagTable(title: text)
            selectedDelegate?.sendData(currentInput, value: value)
        case .priority:
            guard let view = view as? PriorityView else { return }
            let value = view.priority?.title
            selectedDelegate?.sendData(currentInput, value: value)
        }
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
        guard let view = view as? TagView else { return }
        view.textField.text = tagList[indexPath.row].title
        dismiss(animated: true)
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

