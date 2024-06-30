//
//  CastTableViewCell.swift
//  Media
//
//  Created by 아라 on 6/30/24.
//

import UIKit
import SnapKit
import Kingfisher

class CastTableViewCell: UITableViewCell {
    static let identifier = "CastTableViewCell"
    
    let profileImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .lightGray
        return view
    }()
    let nameLabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    let characterLabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        [profileImageView, nameLabel, characterLabel].forEach {
            contentView.addSubview($0)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(profileImageView.snp.height).multipliedBy(0.8)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView).offset(12)
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
        }
        
        characterLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
        }
    }
    
    func configureCell(_ data: Cast) {
        if let profilePath = data.profilePath {
            let imageString = "https://image.tmdb.org/t/p/original/" + profilePath
            let imageURL = URL(string: imageString)
            profileImageView.kf.setImage(with: imageURL)
        }
        
        nameLabel.text = data.name
        characterLabel.text = data.character
    }
}
