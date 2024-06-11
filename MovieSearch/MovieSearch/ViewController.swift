//
//  ViewController.swift
//  MovieSearch
//
//  Created by 아라 on 6/12/24.
//

import UIKit
import Alamofire
import SnapKit

class ViewController: UIViewController {
    let searchBar = UISearchBar()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 40) / 3
        let height = width * 1.3
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    
    var list = MovieResponse(page: 0, results: [], totalPages: 0, totalResults: 0)
    var page = 1
    var totalPages = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        searchBar.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func callRequest(_ target: String) {
        let url = APIURL.searchURL
        let parameters: Parameters = [
            "query" : target
        ]
        let headers: HTTPHeaders = [
            "Authorization" : APIKey.auth
        ]
        
        AF.request(url,
                   parameters: parameters,
                   headers: headers).responseDecodable(of: MovieResponse.self) { [weak self] response in
            guard let self else { return }
            switch response.result {
            case .success(let value):
                totalPages = value.totalPages
                
                if page == 1 {
                    list = value
                } else {
                    list.results.append(contentsOf: value.results)
                }
                    
                collectionView.reloadData()
                
                if page == 1 {
                    collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if list.results.count - 6 == item.row && list.totalPages > page {
                page += 1
                callRequest(searchBar.text!)
            }
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let target = searchBar.text else { return }
        page = 1
        callRequest(target)
        view.endEditing(true)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        let data = list.results[indexPath.row]
        cell.configureCell(data)
        return cell
    }
}

