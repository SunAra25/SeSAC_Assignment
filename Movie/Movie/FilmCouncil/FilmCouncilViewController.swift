//
//  FilmCouncilViewController.swift
//  Movie
//
//  Created by 아라 on 6/6/24.
//

import UIKit
import Alamofire
import SnapKit

enum Wrong: String {
    case format = "ex) 20210101"
    case date = "20031111 ~ 어제 날짜"
}
struct FilmCouncil: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let dailyBoxOfficeList: [Film]
}

struct Film: Decodable {
    let rank: String
    let movieNm: String
    let openDt: String
}

class FilmCouncilViewController: UIViewController {
    let textField = UITextField()
    let underlineView = UIView()
    let searchButton = UIButton()
    let tableView = UITableView()
    
    var list: [Film] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callRequest(getYesterDay())
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
        searchButton.addTarget(self, action: #selector(searchBtnDidTap), for: .touchUpInside)
        
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
    
    func callRequest(_ date: String) {
        let url = APIURL.filmURL + date
        
        AF.request(url).responseDecodable(of: FilmCouncil.self) { [weak self] response in
            guard let self else { return }
            switch response.result {
            case .success(let value):
                list = value.boxOfficeResult.dailyBoxOfficeList
                if list.isEmpty {
                    showAlert(.date)
                    textField.text = ""
                }
            case .failure(let error):
                print(#function)
            }
        }
    }
    
    func showAlert(_ wrong: Wrong) {
        let alert = UIAlertController(title: "날짜를 다시 입력해주세요", message: wrong.rawValue, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func getYesterDay() -> String {
        guard let yesterDay = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.string(from: yesterDay)
        return date
    }
    
    @objc func searchBtnDidTap() {
        guard let text = textField.text else {
            showAlert(.format)
            textField.text = ""
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        guard let date = dateFormatter.date(from: text) else {
            showAlert(.format)
            textField.text = ""
            return
        }
        
        let targetDt = dateFormatter.string(from: date)
        callRequest(targetDt)
        
        view.endEditing(true)
    }
}

extension FilmCouncilViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilmTableViewCell.identifier, for: indexPath) as! FilmTableViewCell
        
        cell.configureUI(list[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
}
