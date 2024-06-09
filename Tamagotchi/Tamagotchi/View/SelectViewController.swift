//
//  ViewController.swift
//  Tamagotchi
//
//  Created by 아라 on 6/7/24.
//

import UIKit
import SnapKit

class SelectViewController: BaseViewController {
    let titleLabel = UILabel()
    let tamagoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setHierarchy()
        setConstraints()
    }
    
    override func configureView() {
        super.configureView()
        
        titleLabel.text = "다마고치 선택하기"
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.font = .bodyB
        
        tamagoCollectionView.delegate = self
        tamagoCollectionView.dataSource = self
        tamagoCollectionView.register(TamagotchiCollectionViewCell.self, forCellWithReuseIdentifier: TamagotchiCollectionViewCell.identifier)
        tamagoCollectionView.backgroundColor = .clear
    }
    
    func setHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(tamagoCollectionView)
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        tamagoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension SelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TamagotchiCollectionViewCell.identifier, for: indexPath) as! TamagotchiCollectionViewCell
        
        cell.imageView.image = UIImage.no
        cell.nameLabel.text = "반짝반짝 다마고치"
        return cell
    }
}

extension SelectViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let inset: CGFloat = 8
        let padding: CGFloat = 8
        let collectionViewSize = screenWidth - inset * 2 - padding * 4
        
        let cellSize = collectionViewSize / 3
        return CGSize(width: cellSize, height: cellSize)
    }
}
