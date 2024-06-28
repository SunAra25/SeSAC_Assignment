//
//  SearchViewController.swift
//  Media
//
//  Created by 아라 on 6/27/24.
//

import UIKit
import SnapKit
import Alamofire

class SearchViewController: UIViewController {
    let searchBar = UISearchBar()
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.delegate = self
        view.dataSource = self
        view.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        return view
    }()
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        
        let screenWidth = UIScreen.main.bounds.width
        let inset: CGFloat = 16
        let padding: CGFloat = 10
        let width: CGFloat = (screenWidth - inset * 2 - padding * 2) / 3
        layout.itemSize = CGSize(width: width, height: 160)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setNavigation()
        setLayout()
    }
    
    func setNavigation() {
        navigationItem.title = "영화 검색"
        let barItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listBtnDidTap))
        barItem.tintColor = .black
        navigationItem.leftBarButtonItem = barItem
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        searchBar.delegate = self
    }
    
    func setLayout() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func listBtnDidTap() {
        let nextVC = ListViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let target = searchBar.text else { return }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as! PosterCollectionViewCell
        
        return cell
    }
}
