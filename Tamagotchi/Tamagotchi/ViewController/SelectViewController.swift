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
    let backgroundView = UIView()
    let alertView = SelectAlertView()
    
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
        
        backgroundView.backgroundColor = .black.withAlphaComponent(0.3)
        backgroundView.isHidden = true
        
        alertView.cancelButton.addTarget(self, action: #selector(cancelButtonDidTap), for: .touchUpInside)
        alertView.isHidden = true
    }
    
    func setHierarchy() {
        [titleLabel, tamagoCollectionView, backgroundView, alertView].forEach {
            view.addSubview($0)
        }
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
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        alertView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    @objc func cancelButtonDidTap() {
        backgroundView.isHidden = true
        alertView.isHidden = true
    }
}

extension SelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TamagotchiCollectionViewCell.identifier, for: indexPath) as! TamagotchiCollectionViewCell
        
        switch indexPath.row {
        case 0: cell.configureCell(Tamagotchi.thorn)
        case 1: cell.configureCell(Tamagotchi.float)
        case 2: cell.configureCell(Tamagotchi.twinkle)
        default: cell.configureCell(Tamagotchi.none)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var tamagotchi: Tamagotchi = .none
        
        switch indexPath.row {
        case 0: tamagotchi = .thorn
        case 1: tamagotchi = .float
        case 2:  tamagotchi = .twinkle
        default: return
        }
        
        backgroundView.isHidden = false
        alertView.isHidden = false
        
        alertView.configureTamagotchi(type: .start, tamagotchi)
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
