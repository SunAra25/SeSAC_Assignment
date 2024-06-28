//
//  ViewController.swift
//  Media
//
//  Created by 아라 on 6/10/24.
//

import UIKit
import Alamofire
import SnapKit

class ListViewController: UIViewController {
    let tableView = UITableView()
    
    var movieIdList: [Int] = [] {
        didSet {
            callDetailRequest()
        }
    }
    
    var mediaList: [MediaDetailResponse] = []
    var cast: [[Cast]] = []
    
    let group = DispatchGroup()
    var page = 1 {
        didSet {
            callMediaRequest()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureLayout()
        callMediaRequest()
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.register(MediaTableViewCell.self, forCellReuseIdentifier: MediaTableViewCell.identifier)
    }

    func configureLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func callMediaRequest() {
        let url = APIURL.movieURL
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
        .responseDecodable(of: MediaResponse.self) { [weak self] response in
            guard let self else { return }
            switch response.result {
            case .success(let value):
                let list = value.results.map { $0.id }
                if page > 1 {
                    movieIdList += list
                } else {
                    movieIdList = list
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callDetailRequest() {
        for id in movieIdList {
            group.enter()
            callMediaDetailRequest(id) {
                self.group.leave()
            }
            
            group.enter()
            callCreditsRequest(id) {
                self.group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    func callMediaDetailRequest(_ id: Int, completionHandler: @escaping () -> Void) {
        let url = APIURL.movieDetailURL + "/\(id)"
        let headers: HTTPHeaders = [
            "Authorization" : APIKey.auth,
            "accept" : "application/json"
        ]
        
        AF.request(
            url,
            headers: headers)
        .responseDecodable(of: MediaDetailResponse.self) { [weak self] response in
            guard let self else { return }
            switch response.result {
            case .success(let value):
                mediaList.append(value)
            case .failure(let error):
                print(error)
            }
            completionHandler()
        }
    }
    
    func callCreditsRequest(_ id: Int, completionHandler: @escaping () -> Void) {
        let url = "\(APIURL.creditsURL)/\(id)/credits"
        let headers: HTTPHeaders = [
            "Authorization" : APIKey.auth,
            "accept" : "application/json"
        ]
        
        AF.request(
            url,
            headers: headers)
        .responseDecodable(of: Credits.self) { [weak self] response in
            guard let self else { return }
            switch response.result {
            case .success(let value):
                cast.append(value.cast)
            case .failure(let error):
                print(error)
            }
            completionHandler()
        }
    }
    
    @objc func listBtnDidTap() {
        
    }
    
    @objc func magnifyinngBtnDidTap() {
        
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieIdList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.identifier, for: indexPath) as! MediaTableViewCell
        
        let media = mediaList[indexPath.row]
        let cast = cast[indexPath.row]
        
        cell.configureCell(media: media, casts: cast)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for item in indexPaths {
            if movieIdList.count - 8 == item.row {
                page += 1
            }
        }
    }
}
