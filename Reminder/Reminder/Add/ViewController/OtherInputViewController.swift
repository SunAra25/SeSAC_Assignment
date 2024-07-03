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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let currentInput else { return }
        var value: String?
        switch currentInput {
        case .deadline:
            guard let view = view as? DeadlineView else { return }
            value = view.textField.text
        case .tag:
            guard let view = view as? TagView else { return }
            value = view.textField.text 
        case .priority:
            guard let view = view as? PriorityView else { return }
            value = view.priority?.title
        }
        selectedDelegate?.sendData(currentInput, value: value)
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

