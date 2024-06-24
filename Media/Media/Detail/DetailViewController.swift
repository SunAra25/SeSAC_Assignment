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
    let similarLabel = UILabel()
    lazy var similarCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.delegate = self
        view.dataSource = self
        view.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        return view
    }()
    let recommendLabel = UILabel()
    lazy var recommendCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.delegate = self
        view.dataSource = self
        view.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        return view
    }()
    let posterLabel = UILabel()
    lazy var posterCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.delegate = self
        view.dataSource = self
        view.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        return view
    }()
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let height: CGFloat = 160
        let width = 160 * 0.7
        layout.itemSize = CGSize(width: width, height: height)
        
        return layout
    }()
    var movieId = 0
    var similarList: [Movie] = [] {
        didSet {
            similarCollectionView.reloadData()
        }
    }
    var recommendList: [Movie] = [] {
        didSet {
            recommendCollectionView.reloadData()
        }
    }
    var posterList: [Poster] = [] {
        didSet {
            posterCollectionView.reloadData()
        }
    }
    
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
        
        similarLabel.text = "비슷한 영화"
        similarLabel.textColor = .black
        similarLabel.textAlignment = .left
        similarLabel.font = .boldSystemFont(ofSize: 14)
        
        recommendLabel.text = "추천 영화"
        recommendLabel.textColor = .black
        recommendLabel.textAlignment = .left
        recommendLabel.font = .boldSystemFont(ofSize: 14)
        
        posterLabel.text = "포스터"
        posterLabel.textColor = .black
        posterLabel.textAlignment = .left
        posterLabel.font = .boldSystemFont(ofSize: 14)
    }
    
    func setLayout() {
        [titleLabel, similarLabel, similarCollectionView, recommendLabel, recommendCollectionView, posterLabel, posterCollectionView].forEach {
            view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        similarLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        similarCollectionView.snp.makeConstraints { make in
            make.top.equalTo(similarLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(160)
        }
        
        recommendLabel.snp.makeConstraints { make in
            make.top.equalTo(similarCollectionView.snp.bottom).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        recommendCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recommendLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(160)
        }
        
        posterLabel.snp.makeConstraints { make in
            make.top.equalTo(recommendCollectionView.snp.bottom).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        posterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(posterLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(160)
        }
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case similarCollectionView: 
            return similarList.count
        case recommendCollectionView: 
            return recommendList.count
        case posterCollectionView:
            return posterList.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as! PosterCollectionViewCell
        
        switch collectionView {
        case similarCollectionView:
            cell.configureCell(data: similarList[indexPath.row])
        case recommendCollectionView:
            cell.configureCell(data: recommendList[indexPath.row])
        case posterCollectionView:
            cell.configureCell(data: posterList[indexPath.row])
        default: break
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
        
        AF.request(
            base + similarURL,
            headers: headers)
        .responseDecodable(of: MovieResponse.self) { [weak self] response in
            guard let self else { return }
            switch response.result {
            case .success(let value):
                similarList = value.results
            case .failure(let error):
                print(error)
            }
        }
        
        AF.request(
            base + recommendURL,
            headers: headers)
        .responseDecodable(of: MovieResponse.self) { [weak self] response in
            guard let self else { return }
            switch response.result {
            case .success(let value):
                recommendList = value.results
            case .failure(let error):
                print(error)
            }
        }
        
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
        }
    }
}
