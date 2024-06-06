//
//  FilmTableViewCell.swift
//  Movie
//
//  Created by 아라 on 6/6/24.
//

import UIKit
import SnapKit

class FilmTableViewCell: UITableViewCell {
    static let identifier = "FilmTableViewCell"
    
    let rankingLabel = UILabel()
    let nameLabel = UILabel()
    let dateLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setHierachy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(_ data: Film) {
        rankingLabel.text = data.rank
        nameLabel.text = data.movieNm
        dateLabel.text = data.openDt
    }
    
    func configure() {
        contentView.backgroundColor = .black
        
        rankingLabel.textAlignment = .center
        rankingLabel.textColor = .black
        rankingLabel.font = .systemFont(ofSize: 16, weight: .heavy)
        rankingLabel.backgroundColor = .white
        
        nameLabel.textAlignment = .left
        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 16, weight: .heavy)
        
        dateLabel.textAlignment = .right
        dateLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 12)
    }
    
    func setHierachy() {
        [rankingLabel, nameLabel, dateLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setConstraints() {
        rankingLabel.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview().inset(16)
            make.width.equalTo(48)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(rankingLabel.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
}
