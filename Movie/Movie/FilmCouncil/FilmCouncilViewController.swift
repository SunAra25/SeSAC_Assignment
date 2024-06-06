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
        textField.backgroundColor = .green
        
        underlineView.backgroundColor = .red
        
        searchButton.backgroundColor = .blue
        
        tableView.backgroundColor = .yellow
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
