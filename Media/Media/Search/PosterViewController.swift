//
//  PosterViewController.swift
//  Media
//
//  Created by 아라 on 6/24/24.
//

import UIKit
import SnapKit
import Alamofire

class PosterViewController: UIViewController {
    let titleLabel = UILabel()
    lazy var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.identifier)
        view.rowHeight = 200
        return view
    }()
    var movieId: Int

    var movieList: [[Movie]] = [[], []]
    var posterList: [Poster] = []
    let titleList = ["비슷한 영화", "추천 영화", "포스터"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setLayout()
        callRequest()
    }
    
    init(movieId: Int) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

extension PosterViewController: UITableViewDelegate, UITableViewDataSource {
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

extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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

extension PosterViewController {
    func callRequest() {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.movieRequest(api: .similar(id: self.movieId)) { [weak self] result, error in
                guard let self else { return }
                if let result = result {
                    movieList[0] = result
                } else if let error = error {
                    print(error)
                }
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.movieRequest(api: .recommend(id: self.movieId)) { [weak self] result, error in
                guard let self else { return }
                if let result = result {
                    movieList[1] = result
                } else if let error = error {
                    print(error)
                }
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.posterRequest(api: .poster(id: self.movieId)) { [weak self] result, error in
                guard let self else { return }
                if let result = result {
                    posterList = result
                } else if let error = error {
                    print(error)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            tableView.reloadData()
        }
    }
}
