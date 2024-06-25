//
//  DetailViewController.swift
//  Media
//
//  Created by 아라 on 6/24/24.
//

import UIKit
import SnapKit
import Alamofire

class DetailViewController: UIViewController {
    let titleLabel = UILabel()
    lazy var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.identifier)
        view.rowHeight = 200
        return view
    }()
    var movieId = 0

    var movieList: [[Movie]] = [[], []]
    var posterList: [Poster] = []
    let titleList = ["비슷한 영화", "추천 영화", "포스터"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setLayout()
        callRequest()
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        titleLabel.text = "영화 제목"
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.font = .boldSystemFont(ofSize: 16)
    }
    
    func setLayout() {
        [titleLabel, tableView].forEach {
            view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? movieList.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.identifier, for: indexPath) as! PosterTableViewCell
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        
        let tag = indexPath.section * movieList.count + indexPath.row
        cell.collectionView.tag = tag
        cell.titleLabel.text = titleList[tag]
        
        cell.collectionView.reloadData()
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView.tag < movieList.count ? movieList[collectionView.tag].count : posterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as! PosterCollectionViewCell
       
        if collectionView.tag < movieList.count {
            let data = movieList[collectionView.tag][indexPath.row]
            cell.configureCell(data: data)
        } else {
            let data = posterList[indexPath.row]
            cell.configureCell(data: data)
        }
        
        return cell
    }
}

extension DetailViewController {
    func callRequest() {
        let base = APIURL.poster
        let similarURL = "\(movieId)/similar"
        let recommendURL = "\(movieId)/recommendations"
        let posterURL = "\(movieId)/images"
        
        let headers: HTTPHeaders = [
            "Authorization" : APIKey.auth,
            "accept" : "application/json"
        ]
        
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            AF.request(
                base + similarURL,
                headers: headers)
            .responseDecodable(of: MovieResponse.self) { [weak self] response in
                guard let self else { return }
                switch response.result {
                case .success(let value):
                    movieList[0] = value.results
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            AF.request(
                base + recommendURL,
                headers: headers)
            .responseDecodable(of: MovieResponse.self) { [weak self] response in
                guard let self else { return }
                switch response.result {
                case .success(let value):
                    movieList[1] = value.results
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            AF.request(
                base + posterURL,
                headers: headers)
            .responseDecodable(of: PosterResponse.self) { [weak self] response in
                guard let self else { return }
                switch response.result {
                case .success(let value):
                    posterList = value.posters
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            tableView.reloadData()
            
            dump(movieList)
            dump(posterList)
        }
    }
}
