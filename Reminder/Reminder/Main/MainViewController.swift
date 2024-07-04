//
//  MainViewController.swift
//  Reminder
//
//  Created by 아라 on 7/3/24.
//

import UIKit
import SnapKit

final class MainViewController: BaseViewController {
    private lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        view.delegate = self
        view.dataSource = self
        view.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifer)
        return view
    }()
    private let flowlayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        
        let width = UIScreen.main.bounds.width
        let inset: CGFloat = 12
        let padding: CGFloat = 12
        let size = (width - inset * 2 - padding) / 2
        
        layout.itemSize = CGSize(width: size, height: 100)
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 12)
        return layout
    }()
    private lazy var addButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        var attr = AttributedString.init("새로운 할 일")
        attr.font = UIFont.systemFont(ofSize: 16)
        
        config.attributedTitle = attr
        config.image = UIImage(systemName: "plus.circle.fill")
        config.imagePlacement = .leading
        config.imagePadding = 12
        button.configuration = config
        
        button.addTarget(self, action: #selector(addBtnDidTap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(sendUpdateNotification), name: NSNotification.Name("UpdateTodoTable"), object: nil)
    }
    
    override func setHierarchy() {
        [collectionView, addButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        addButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(addButton.snp.top).offset(8)
        }
    }
    
    @objc func addBtnDidTap() {
        let nextVC = AddViewController()
        present(nextVC, animated: true)
    }
    
    @objc func sendUpdateNotification(notification: NSNotification) {
        collectionView.reloadData()
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Category.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifer, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }

        let rawValue = Category.allCases[indexPath.row].rawValue
        guard let category = Category(rawValue: rawValue) else { return cell }
        var data: (Category, Int) = (category, -1)
        switch category {
        case .today: data.1 = repository.fetchTodayTodo().count
        case .expected: data.1 = repository.fetchScheduledTodo().count
        case .all: data.1 = repository.fetchAllTodo().count
        case .flag: data.1 = repository.fetchFlaggedTodo().count
        case .done: data.1 = repository.fetchCompletedTodo().count
        }
        
        cell.configureCell(data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = Category.allCases[indexPath.row]
        let nextVC = ListViewController(category)
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

enum Category: String, CaseIterable {
    case today = "오늘"
    case expected = "예정"
    case all = "전체"
    case flag = "깃발 표시"
    case done = "완료됨"
    
    var backgroundColor: UIColor {
        switch self {
        case .today: return .systemBlue
        case .expected: return .systemRed
        case .all: return .systemGray
        case .flag: return .systemOrange
        case .done: return .systemCyan
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .today: return UIImage(systemName: "calendar.circle.fill")
        case .expected: return UIImage(systemName: "calendar.circle.fill")
        case .all: return UIImage(systemName: "tray.circle.fill")
        case .flag: return UIImage(systemName: "flag.circle.fill")
        case .done: return UIImage(systemName: "checkmark.circle.fill")
        }
    }
}
