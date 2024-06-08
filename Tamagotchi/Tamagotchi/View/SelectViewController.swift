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
    let tamagoCollectionView = UICollectionView()
    
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
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
}
