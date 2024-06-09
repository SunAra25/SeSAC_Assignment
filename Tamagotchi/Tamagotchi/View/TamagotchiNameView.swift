//
//  NameView.swift
//  Tamagotchi
//
//  Created by 아라 on 6/9/24.
//

import UIKit
import SnapKit

class TamagotchiNameView: UIView {
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.border?.withAlphaComponent(0.5).cgColor
        
        nameLabel.textColor = .font
        nameLabel.textAlignment = .center
        nameLabel.font = .capB
    }
    
    func setLayout() {
        self.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(4)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
    }
}
