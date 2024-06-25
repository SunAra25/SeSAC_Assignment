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

    var posterList: [[Poster]] = []
    let titleList = ["비슷한 영화", "추천 영화", "포스터"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setLayout()
        //callRequest()
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.identifier, for: indexPath) as! PosterTableViewCell
        
        cell.backgroundColor = .red
        return cell
    }
}
