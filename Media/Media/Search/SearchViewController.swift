//
//  SearchViewController.swift
//  Media
//
//  Created by 아라 on 6/27/24.
//

import UIKit
import SnapKit
import Alamofire

final class SearchViewController: UIViewController {
    private let searchBar = UISearchBar()
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.delegate = self
        view.dataSource = self
        view.prefetchDataSource = self
        view.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        return view
    }()
    private let flowLayout: UICollectionViewFlowLayout = {
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
    private var movieList: [Movie] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    private var target = "" {
        didSet {
            callRequest()
        }
    }
    
    private var page = 1 {
        didSet {
            callRequest()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setNavigation()
        setLayout()
    }
    
    private func setNavigation() {
        navigationItem.title = "영화 검색"
        let barItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listBtnDidTap))
        barItem.tintColor = .black
        navigationItem.leftBarButtonItem = barItem
    }
    
    private func configureView() {
        view.backgroundColor = .white
        
        searchBar.delegate = self
    }
    
    private func setLayout() {
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
    
    private func callRequest() {
        let url = APIURL.search
        let headers: HTTPHeaders = [
            "Authorization" : APIKey.auth,
            "accept" : "application/json"
        ]
        let parameters: Parameters = [
            "query" : target,
            "page" : "\(page)"
        ]
        
        AF.request(
            url,
            parameters: parameters,
            headers: headers)
        .responseDecodable(of: MovieResponse.self) { [weak self] response in
            guard let self else { return }
            switch response.result {
            case .success(let value):
                let list = value.results
                if page > 1 {
                    movieList += list
                } else {
                    movieList = list
                }
            case .failure(let error):
                print(error)
            }
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
        self.target = target
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as! PosterCollectionViewCell
        let data = movieList[indexPath.row]
        cell.configureCell(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = movieList[indexPath.row].id
        let nextVC = YoutubeViewController(movieId: data)
        navigationController?.pushViewController(nextVC, animated: true)
    }
}


extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let standard = movieList.count - 9
        if indexPaths.contains(where: { $0.row > standard }) {
            page += 1
        }
    }
}
