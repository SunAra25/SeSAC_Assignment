//
//  TamagotchiCollectionViewCell.swift
//  Tamagotchi
//
//  Created by 아라 on 6/8/24.
//

import UIKit
import SnapKit

class TamagotchiCollectionViewCell: UICollectionViewCell {
    static let identifier = "TamagotchiCollectionViewCell"
    let imageView = UIImageView()
    let nameView = TamagotchiNameView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ data: Tamagotchi) {
        nameView.nameLabel.text = data.rawValue
        imageView.image = data.tamagoImage
    }
    
    func configureView() {
        nameView.nameLabel.textColor = .font
        nameView.nameLabel.textAlignment = .center
        nameView.nameLabel.font = .capB
    }
    
    func setLayout() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.width.equalTo(imageView.snp.height)
        }
        
        nameView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(4)
        }
    }
}
