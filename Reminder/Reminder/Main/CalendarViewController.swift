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
    private let tableView: UITableView = {
        let view = UITableView()
        
        return view
    }()
    
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
        // TODO: tableView reload
    }
}
