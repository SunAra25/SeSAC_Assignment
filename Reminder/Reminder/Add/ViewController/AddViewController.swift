//
//  AddViewController.swift
//  Reminder
//
//  Created by 아라 on 7/2/24.
//

import UIKit
import SnapKit
import PhotosUI

protocol SelectedDataDelegate {
    func sendData<T>(_ input: Input, value: T)
}

final class AddViewController: BaseViewController {
    private let cancleButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        var attr = AttributedString.init("취소")
        attr.font = UIFont.systemFont(ofSize: 16)
        
        config.attributedTitle = attr
        button.configuration = config
        return button
    }()
    private let addButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        var attr = AttributedString.init("추가")
        attr.font = UIFont.systemFont(ofSize: 16)
        
        config.attributedTitle = attr
        button.configuration = config
        button.isEnabled = false
        
        button.addTarget(self, action: #selector(addBtnDidTap), for: .touchUpInside)
        return button
    }()
    private let naviTitleLabel = {
        let label = UILabel()
        label.text = "새로운 할 일"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    private lazy var tableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.delegate = self
        view.dataSource = self
        view.register(MemoInputTableViewCell.self, forCellReuseIdentifier: MemoInputTableViewCell.identifer)
        view.register(OtherInputTableViewCell.self, forCellReuseIdentifier: OtherInputTableViewCell.identifer)
        return view
    }()
    
    private let inputs = ["마감일", "태그", "우선순위", "이미지 추가"]
    private var selectedPriority: String?
    private var selectedImage: UIImage?
    private var selectedDate: Date?
    private var selectedTag: TagTable?
    private var memoTitle = ""
    private var content: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         NotificationCenter.default.post(name:NSNotification.Name("DismissAddView"), object: nil, userInfo: nil)
    }
    
    override func setHierarchy() {
        [cancleButton, addButton, naviTitleLabel, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        naviTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.centerX.equalToSuperview()
        }
        
        cancleButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.centerY.equalTo(naviTitleLabel)
        }
        
        addButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.centerY.equalTo(naviTitleLabel)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(naviTitleLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
    }
    
    @objc func addBtnDidTap() {
        let title = memoTitle
        let content = content
        let deadline = selectedDate?.withoutTime()
        let priority = selectedPriority
        let item = TodoTable(title: title, content: content, deadline: deadline, priority: priority)
        guard let tag = selectedTag else { return }
        let id = repository.createItem(tag: selectedTag, item)
        
        if let image = selectedImage {
            saveImageToDocument(image: image, filename: "\(id)")
        }
        
        dismiss(animated: true)
    }
    
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }
}

extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : inputs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoInputTableViewCell.identifer, for: indexPath) as? MemoInputTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            
            cell.titleTextField.delegate = self
            cell.memoTextView.delegate = self
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherInputTableViewCell.identifer, for: indexPath) as? OtherInputTableViewCell else { return UITableViewCell() }
            let title = inputs[indexPath.row]
            cell.selectionStyle = .none
            cell.configureCell((title, selectedDate, selectedTag, selectedPriority, selectedImage))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 { return }
        if indexPath.row < inputs.count - 1 {
            let nextVC = OtherInputViewController(indexPath.row)
            nextVC.selectedDelegate = self
            present(nextVC, animated: true)
        } else {
            var config = PHPickerConfiguration()
            config.selectionLimit = 1
            config.filter = .images
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
            
            present(picker, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 180 : 72
    }
}

extension AddViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let input = textField.text else { return }
        addButton.isEnabled = !input.isEmpty && selectedTag != nil
        memoTitle = input
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension AddViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .systemGray2 {
            textView.text = ""
            textView.textColor = .label
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let input = textView.text else { return }
        
        content = input
    }
}

extension AddViewController: SelectedDataDelegate {
    func sendData<T>(_ input: Input, value: T) {
        let index = input.rawValue
        switch index {
        case 0: selectedDate = value as? Date
        case 1: 
            selectedTag = value as? TagTable
            addButton.isEnabled = selectedTag != nil
        case 2: selectedPriority = value as? String
        case 3: selectedImage = value as? UIImage
        default: break
        }
        
        tableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .automatic)
    }
}

extension AddViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        var view: UIView? = touch.view
        
        while let currentView = view {
            guard !(currentView is UITableView || currentView is UITableViewCell) else {
                return false
            }
            view = currentView.superview
        }
        
        return true
    }
}

extension AddViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    selectedImage = image as? UIImage
                    tableView.reloadRows(at: [IndexPath(row: inputs.count - 1, section: 1)], with: .automatic)
                }
            }
        }
    }
}
