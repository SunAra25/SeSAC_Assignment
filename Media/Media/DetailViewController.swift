//
//  DetailViewController.swift
//  Media
//
//  Created by 아라 on 6/24/24.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    let titleLabel = UILabel()
    let similarLabel = UILabel()
    let similarCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    let recommendLabel = UILabel()
    let recommendCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    let posterLabel = UILabel()
    let posterCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setLayout()
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
        
        similarCollectionView.backgroundColor = .lightGray
        
        recommendLabel.text = "추천 영화"
        recommendLabel.textColor = .black
        recommendLabel.textAlignment = .left
        recommendLabel.font = .boldSystemFont(ofSize: 14)
        
        recommendCollectionView.backgroundColor = .lightGray
        
        posterLabel.text = "포스터"
        posterLabel.textColor = .black
        posterLabel.textAlignment = .left
        posterLabel.font = .boldSystemFont(ofSize: 14)
        
        posterCollectionView.backgroundColor = .lightGray
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
