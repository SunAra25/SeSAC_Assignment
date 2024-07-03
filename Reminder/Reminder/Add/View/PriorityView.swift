//
//  PriorityView.swift
//  Reminder
//
//  Created by 아라 on 7/3/24.
//

import UIKit

class PriorityView: BaseView {
    private lazy var segmentControl = {
        let view = UISegmentedControl()
        Priority.allCases.forEach {
            view.insertSegment(withTitle: $0.title, at: $0.rawValue, animated: true)
        }
        view.backgroundColor = .systemGray4
        view.addTarget(self, action: #selector(priorityDidChanged), for: .valueChanged)
        return view
    }()
    var priority: Priority = .normal
    
    override func setHierarchy() {
        addSubview(segmentControl)
    }
    
    override func setConstraints() {
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(40)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(52)
        }
    }
    
    @objc func priorityDidChanged(_ segment: UISegmentedControl) {
        let index = segment.selectedSegmentIndex
        guard let value = Priority(rawValue: index) else { return }
        priority = value
    }
}

enum Priority: Int, CaseIterable {
    case low = 0
    case normal
    case hight
    
    var title: String {
        switch self {
        case .low: "낮음"
        case .normal: "보통"
        case .hight: "높음"
        }
    }
}
