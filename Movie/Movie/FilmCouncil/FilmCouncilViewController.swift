//
//  FilmCouncilViewController.swift
//  Movie
//
//  Created by 아라 on 6/6/24.
//

import UIKit
import SnapKit

class FilmCouncilViewController: UIViewController {
    let textField = UITextField()
    let underlineView = UIView()
    let searchButton = UIButton()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setHierachy()
        setConstraints()
    }
    
    func configureUI() {
        view.backgroundColor = .black
        
        textField.textColor = .white
        textField.font = .boldSystemFont(ofSize: 16)
        textField.keyboardType = .numberPad
        
        underlineView.backgroundColor = .white
        
        searchButton.backgroundColor = .white
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
        tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: FilmTableViewCell.identifier)
        tableView.rowHeight = 60
    }
    
    func setHierachy() {
        [textField, underlineView, searchButton, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        searchButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.width.equalTo(60)
            make.height.equalTo(48)
        }
        
        underlineView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(searchButton.snp.leading).offset(-8)
            make.bottom.equalTo(searchButton)
            make.height.equalTo(4)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(searchButton)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(searchButton.snp.leading).offset(-8)
            make.bottom.equalTo(underlineView.snp.top)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(underlineView.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension FilmCouncilViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilmTableViewCell.identifier, for: indexPath) as! FilmTableViewCell
        
        cell.nameLabel.text = "주디"
        cell.dateLabel.text = "2020-01-08"
        cell.rankingLabel.text = "1"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
