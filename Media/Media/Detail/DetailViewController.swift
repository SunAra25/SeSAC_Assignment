//
//  DetailViewController.swift
//  Media
//
//  Created by 아라 on 6/29/24.
//

import UIKit
import SnapKit
import Kingfisher

final class DetailViewController: UIViewController {
    private let backPosterImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    private let posterImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    private let overviewTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "OverView"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .systemGray3
        return label
    }()
    private let overviewContentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let castTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cast"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .systemGray3
        return label
    }()
    private lazy var castTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.identifier)
        view.rowHeight = 80
        return view
    }()
    private var casts: [Cast] {
        didSet {
            castTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
    }
    
    init(detail: MediaDetailResponse, casts: [Cast]) {
        self.casts = casts
        movieTitleLabel.text = detail.title
        overviewContentLabel.text = detail.overview
        
        super.init(nibName: nil, bundle: nil)
        
        if let backPath = detail.backdropPath, let posterPath = detail.posterPath {
            let backURL = URL(string: "https://image.tmdb.org/t/p/original/" + backPath)
            let posterURL = URL(string: "https://image.tmdb.org/t/p/original/" + posterPath)
            backPosterImageView.kf.setImage(with: backURL)
            posterImageView.kf.setImage(with: posterURL)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        [backPosterImageView, movieTitleLabel, posterImageView, overviewTitleLabel, overviewContentLabel, castTitleLabel, castTableView].forEach {
            view.addSubview($0)
        }
        
        backPosterImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(260)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(backPosterImageView).inset(16)
            make.height.equalTo(20)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(backPosterImageView).inset(16)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.6)
        }
        
        overviewTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(backPosterImageView.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        overviewContentLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewTitleLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        castTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewContentLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        castTableView.snp.makeConstraints { make in
            make.top.equalTo(castTitleLabel.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return casts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as! CastTableViewCell
        
        cell.configureCell(casts[indexPath.row])
        return cell
    }
}
