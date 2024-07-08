//
//  DetailViewController.swift
//  Reminder
//
//  Created by 아라 on 7/3/24.
//

import UIKit
import SnapKit

final class DetailViewController: BaseViewController {
    private let stackView = {
        let view = UIStackView()
        view.spacing = 8
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .fill
        return view
    }()
    private lazy var memoView = {
        let view = UIView()
        view.isHidden = todo.content == nil
        return view
    }()
    private let memoTitleLabel = {
        let label = UILabel()
        label.text = "메모"
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    private lazy var memoContentLabel = {
        let label = UILabel()
        label.text = todo.content
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        return label
    }()
    private lazy var tagView = {
        let view = UIView()
        view.isHidden = todo.main.first == nil
        return view
    }()
    private let tagTitleLabel = {
        let label = UILabel()
        label.text = "태그"
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    private lazy var tagContentLabel = {
        let label = UILabel()
        label.text = todo.main.first?.title
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        return label
    }()
    private lazy var deadlineView = {
        let view = UIView()
        view.isHidden = todo.deadline == nil
        return view
    }()
    private let deadlineTitleLabel = {
        let label = UILabel()
        label.text = "마감일자"
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    private lazy var deadlineContentLabel = {
        let label = UILabel()
        label.text = todo.deadline?.toString()
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        return label
    }()
    private lazy var priorityView = {
        let view = UIView()
        view.isHidden = todo.priority == nil
        return view
    }()
    private let priorityTitleLabel = {
        let label = UILabel()
        label.text = "우선순위"
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    private lazy var priorityContentLabel = {
        let label = UILabel()
        label.text = todo.priority
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        return label
    }()
    private let todo: TodoTable
    
    init(_ todo: TodoTable) {
        self.todo = todo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setNavigation() {
        super.setNavigation()
        navigationItem.title = todo.title
    }
    
    override func setHierarchy() {
        view.addSubview(stackView)
        
        [memoTitleLabel, memoContentLabel].forEach { memoView.addSubview($0) }
        [tagTitleLabel, tagContentLabel].forEach { tagView.addSubview($0) }
        [deadlineTitleLabel, deadlineContentLabel].forEach { deadlineView.addSubview($0) }
        [priorityTitleLabel, priorityContentLabel].forEach { priorityView.addSubview($0) }
        
        [memoView, tagView, deadlineView, priorityView].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    override func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide)
        }
        
        memoView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
        
        memoTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }

        memoContentLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(memoTitleLabel.snp.trailing).offset(8)
        }
        
        tagView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
        
        tagTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }

        tagContentLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(tagTitleLabel.snp.trailing).offset(8)
        }
        
        deadlineView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
        
        deadlineTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }

        deadlineContentLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(deadlineTitleLabel.snp.trailing).offset(8)
        }
        
        priorityView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
        
        priorityTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }

        priorityContentLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(priorityTitleLabel.snp.trailing).offset(8)
        }
    }
}
