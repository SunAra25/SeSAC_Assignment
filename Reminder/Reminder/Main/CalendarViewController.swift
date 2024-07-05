//
//  CalendarViewController.swift
//  Reminder
//
//  Created by 아라 on 7/5/24.
//

import UIKit
import FSCalendar
import SnapKit

final class CalendarViewController: BaseViewController {
    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar(frame: .zero)
        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.headerHeight = 50
        calendar.appearance.headerTitleFont = .boldSystemFont(ofSize: 18)
        calendar.appearance.headerTitleColor = .label
        calendar.appearance.headerTitleAlignment = .center
        calendar.appearance.headerDateFormat = "yyyy년 MM월"
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.titlePlaceholderColor = .label.withAlphaComponent(0.2)
        
        calendar.appearance.weekdayFont = .systemFont(ofSize: 14)
        calendar.appearance.weekdayTextColor = .systemGray2
        
        calendar.appearance.titleFont = .boldSystemFont(ofSize: 16)
        calendar.appearance.titleDefaultColor = .label
        calendar.appearance.titleSelectionColor = .systemBlue
        calendar.appearance.titleTodayColor = .systemBlue
        
        calendar.appearance.todayColor = .clear
        calendar.appearance.selectionColor = .systemBlue.withAlphaComponent(0.4)
        
        calendar.locale = Locale(identifier: "ko_KR")
        return calendar
    }()
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.isScrollEnabled = true
        view.delegate = self
        view.dataSource = self
        view.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifer)
        return view
    }()
    private lazy var list = repository.fetchTodayTodo() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func setHierarchy() {
        view.addSubview(calendar)
        view.addSubview(tableView)
    }
    
    override func setConstraints() {
        calendar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(300)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(16)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        list = repository.fetchTodo(selectedDate: date)
    }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    @objc func radioBtnDidTap(_ sender: UIButton) {
        let index = sender.tag
        let data = list[index]
        
        repository.itemCompleted(data)
        tableView.reloadData()
    }
}
