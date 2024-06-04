//
//  MainViewController.swift
//  Movie
//
//  Created by 아라 on 6/5/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    let backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.background
        view.contentMode = .scaleAspectFill
        return view
    }()
    let mainImageView: UIImageView = {
        let view = UIImageView()
        view.setPoster()
        view.image = UIImage._2
        return view
    }()
    let mainContentLabel: UILabel = {
        let label = UILabel()
        label.text = "응원하고픈.흥미진진.사극.전투.한국작품"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.playNormal, for: .normal)
        button.setTitle("", for: .normal)
        button.setImage(UIImage.playHighlighted, for: .highlighted)
        button.setTitle("", for: .highlighted)
        return button
    }()
    let likeButton: UIButton = {
        let button = UIButton()
        button.setTitle("내가 찜한 리스트", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 11, weight: .semibold)
        button.tintColor = .white
        button.backgroundColor = .gray
        button.layer.cornerRadius = 7
        return button
    }()
    let risingLabel: UILabel = {
        let label = UILabel()
        label.text = "지금 뜨는 콘텐츠"
        label.textAlignment = .left
        label.textColor = .label
        label.font = .systemFont(ofSize: 22, weight: .heavy)
        return label
    }()
    let firstImageView: UIImageView = {
        let view = UIImageView()
        view.setPoster()
        view.image = UIImage.알라딘
        return view
    }()
    let secondImageView: UIImageView = {
        let view = UIImageView()
        view.setPoster()
        view.image = UIImage.아바타
        return view
    }()
    let thirdImageView: UIImageView = {
        let view = UIImageView()
        view.setPoster()
        view.image = UIImage.어벤져스엔드게임
        return view
    }()
    let newEpisodeLabel: UILabel = {
        let label = UILabel()
        label.text = "새로운 에피소드"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        label.backgroundColor = .red
        label.layer.cornerRadius = 2
        return label
    }()
    let watchLabel: UILabel = {
        let label = UILabel()
        label.text = " 지금 시청하기 "
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        label.backgroundColor = .white
        label.layer.cornerRadius = 2
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.clipsToBounds = true
        return label
    }()
    let top10ImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.top10Badge
        return view
    }()
    let newSeriesLabel: UILabel = {
        let label = UILabel()
        label.text = "새로운 시리즈"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        label.backgroundColor = .red
        label.layer.cornerRadius = 2
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setHierachy()
        setConstraints()
    }
    
    func configureView() {
        view.backgroundColor = .black
    }
    
    func setHierachy() {
        [backgroundView, mainImageView, risingLabel, firstImageView, secondImageView, thirdImageView, mainContentLabel, playButton, likeButton, top10ImageView, newEpisodeLabel, newSeriesLabel, watchLabel].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(550)
        }
        
        playButton.snp.makeConstraints { make in
            make.leading.equalTo(mainImageView.snp.leading).offset(16)
            make.bottom.equalTo(mainImageView.snp.bottom).offset(-16)
            make.width.equalTo(120)
            make.height.equalTo(48)
        }
        
        likeButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(mainImageView).offset(-16)
            make.width.equalTo(120)
            make.height.equalTo(48)
        }
        
        mainContentLabel.snp.makeConstraints { make in
            make.bottom.equalTo(playButton.snp.top).offset(-8)
            make.centerX.equalToSuperview()
        }
        
        risingLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(4)
        }
        
        firstImageView.snp.makeConstraints { make in
            make.top.equalTo(risingLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(150)
        }
        
        secondImageView.snp.makeConstraints { make in
            make.top.equalTo(risingLabel.snp.bottom).offset(4)
            make.leading.equalTo(firstImageView.snp.trailing).offset(4)
            make.width.equalTo(firstImageView)
            make.height.equalTo(150)
        }
        
        thirdImageView.snp.makeConstraints { make in
            make.top.equalTo(risingLabel.snp.bottom).offset(4)
            make.leading.equalTo(secondImageView.snp.trailing).offset(4)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(firstImageView)
            make.height.equalTo(150)
        }
        
        top10ImageView.snp.makeConstraints { make in
            make.top.trailing.equalTo(secondImageView)
        }
        
        watchLabel.snp.makeConstraints { make in
            make.centerX.bottom.equalTo(secondImageView)
            make.width.equalTo(80)
            make.height.equalTo(16)
        }
        
        newEpisodeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(secondImageView)
            make.bottom.equalTo(watchLabel.snp.top)
            make.width.equalTo(80)
            make.height.equalTo(16)
        }
        
        newSeriesLabel.snp.makeConstraints { make in
            make.centerX.bottom.equalTo(thirdImageView)
            make.width.equalTo(80)
            make.height.equalTo(16)
        }
    }
}
