//
//  ViewController.swift
//  DiffablePractice
//
//  Created by 아라 on 7/18/24.
//

import UIKit
import SnapKit

private enum Setting: Int, CaseIterable {
    case all = 0
    case personal
    case other
    
    var title: String {
        switch self {
        case .all: "전체 설정"
        case .personal: "개인 설정"
        case .other: "기타"
        }
    }
    
    var options: [Option] {
        switch self {
        case .all: [Option(title: "공지사항"), Option(title: "실험실"), Option(title: "버전 정보")]
        case .personal: [Option(title: "개인/보안"), Option(title: "알림"), Option(title: "채팅"), Option(title: "멀티프로필")]
        case .other: [Option(title: "고객센터/도움말")]
        }
    }
}

private struct Option: Hashable, Identifiable {
    let id = UUID()
    let title: String
}

final class ViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        view.backgroundColor = .lightGray
        return view
    }()
    private let compositionalLayout: UICollectionViewLayout = {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped )
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<Setting, Option>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setLayout()
        configureDataSource()
        updateSnapshot()
    }
    
    private func setLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureDataSource() {
        var registeration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!
        
        registeration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier
            content.textProperties.color = .label
            content.textProperties.font = .systemFont(ofSize: 14)
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: registeration, for: indexPath, item: itemIdentifier.title)
            return cell
        })
    }
    
    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Setting, Option>()
        snapshot.appendSections(Setting.allCases)
        snapshot.appendItems(Setting.all.options, toSection: .all)
        snapshot.appendItems(Setting.personal.options, toSection: .personal)
        snapshot.appendItems(Setting.other.options, toSection: .other)
        
        dataSource.apply(snapshot)
    }
}
