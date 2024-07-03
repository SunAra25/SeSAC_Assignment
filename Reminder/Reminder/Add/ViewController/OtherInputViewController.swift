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
    
    private var currentView: UIView?
    
    init(_ num: Int) {
        super.init(nibName: nil, bundle: nil)
        guard let inputView = Input(rawValue: num)?.view else { return }
        currentView = inputView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = currentView
    }
}

extension OtherInputViewController: UITextFieldDelegate {
    
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

