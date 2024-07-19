//
//  ChattingViewController.swift
//  DiffablePractice
//
//  Created by 아라 on 7/19/24.
//

import UIKit

final class ChattingViewController: UIViewController {
    private enum Section: CaseIterable {
        case open
        case personal
    }
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        view.backgroundColor = .lightGray
        return view
    }()
    private let compositionalLayout: UICollectionViewLayout = {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.headerMode = .none
        config.separatorConfiguration.topSeparatorInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        config.separatorConfiguration.bottomSeparatorInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, ChatRoom>!
    
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
        var registeration: UICollectionView.CellRegistration<UICollectionViewListCell, ChatRoom>!
        
        registeration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.chatroomName
            content.textProperties.color = .label
            content.textProperties.font = .boldSystemFont(ofSize: 18)
            content.secondaryText = itemIdentifier.chatList.last?.message
            content.secondaryTextProperties.color = .secondaryLabel
            content.secondaryTextProperties.font = .systemFont(ofSize: 16)
            
            if let imgString =  itemIdentifier.chatroomImage.first, let image = UIImage(named: imgString) {
                content.image = image.cropSquare()
            } else {
                content.image = UIImage(systemName: "star")
            }
            
            content.imageProperties.maximumSize = .init(width: 40, height: 40)
            content.imageProperties.cornerRadius = 20
            
            content.imageToTextPadding = 16
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: registeration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ChatRoom>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(mockChatList, toSection: Section.personal)
        
        dataSource.apply(snapshot)
    }
}
