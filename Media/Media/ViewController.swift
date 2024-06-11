//
//  ViewController.swift
//  Media
//
//  Created by 아라 on 6/10/24.
//

import UIKit
import Alamofire
import SnapKit

class ViewController: UIViewController {
    let tableView = UITableView()
    
    var mediaList: [MediaDetailResponse] = [] {
        didSet {
            if mediaList.count == cast.count {
                tableView.reloadData()
            }
        }
    }
    
    var cast: [[Cast]] = [[]] {
        didSet {
            if mediaList.count == cast.count {
                tableView.reloadData()
            }
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
        
        let left = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listBtnDidTap))
        let right = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(magnifyinngBtnDidTap))
        
        navigationItem.leftBarButtonItem = left
        navigationItem.rightBarButtonItem = right
        
        tableView.delegate = self
        tableView.dataSource = self
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
        
        AF.request(
            url,
            headers: headers)
        .responseDecodable(of: MediaResponse.self) { [weak self] response in
            guard let self else { return }
            switch response.result {
            case .success(let value):
                mediaList = []
                
                for result in value.results {
                    callMediaDetailRequest(result.id)
                    callCreditsRequest(result.id)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callMediaDetailRequest(_ id: Int) {
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
        }
    }
    
    func callCreditsRequest(_ movieId: Int) {
        let url = "\(APIURL.creditsURL)/\(movieId)/credits"
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
        }
    }
    
    @objc func listBtnDidTap() {
        
    }
    
    @objc func magnifyinngBtnDidTap() {
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.identifier, for: indexPath) as! MediaTableViewCell
        let media = mediaList[indexPath.row]
        let cast = cast[indexPath.row]
       
        cell.configureCell(media: media, casts: cast)
        return cell
    }
}
