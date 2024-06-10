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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureLayout()
        callRequest()
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
    
    func callRequest() {
        let url = APIURL.trendURL
        let headers: HTTPHeaders = [
            "Authorization" : APIKey.auth,
            "accept" : "application/json"
        ]
        AF.request(
            url,
            headers: headers)
            .responseString() { response in
                print(response)
            }
    }
    
    @objc func listBtnDidTap() {
        
    }
    
    @objc func magnifyinngBtnDidTap() {
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.identifier, for: indexPath) as! MediaTableViewCell
        
        return cell
    }
}
