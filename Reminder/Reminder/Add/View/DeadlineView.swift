//
//  DeadlineView.swift
//  Reminder
//
//  Created by 아라 on 7/3/24.
//

import UIKit
import SnapKit

final class DeadlineView: BaseView {
    private lazy var datePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.addTarget(self, action: #selector(datePickerDidChanged), for: [.valueChanged])
        return picker
    }()
    lazy var textField = {
        let field = UITextField()
        field.text = dateToString(Date())
        field.textColor = .label
        field.tintColor = .label
        field.textAlignment = .center
        field.backgroundColor = .systemGray4
        field.inputView = datePicker
        field.layer.cornerRadius = 12
        return field
    }()
    
    override func setHierarchy() {
        addSubview(textField)
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(40)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(48)
        }
    }
    
    private func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
    
    @objc private func datePickerDidChanged(_ datePicker: UIDatePicker) {
        let date = datePicker.date
        textField.text = dateToString(date)
    }
}
