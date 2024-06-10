//
//  MediaTableViewCell.swift
//  Media
//
//  Created by 아라 on 6/10/24.
//

import UIKit
import SnapKit

class MediaTableViewCell: UITableViewCell {
    static let identifier = "MediaTableViewCell"
    
    let dateLabel = UILabel()
    let categoryLabel = UILabel()
    let mediaView = UIView()
    let mediaImageView = UIImageView()
    let gradeTitleLabel = UILabel()
    let gradeScoreLabel = UILabel()
    let titleLabel = UILabel()
    let charactersLabel = UILabel()
    let dividerView = UIView()
    let detailLabel = UILabel()
    let detailImageView = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
        setHierachy()
        setConstraints()
    }
    
    func configureView() {
        dateLabel.textColor = .darkGray
        dateLabel.textAlignment = .left
        dateLabel.font = .systemFont(ofSize: 12)
        
        categoryLabel.textColor = .black
        categoryLabel.textAlignment = .left
        categoryLabel.font = .boldSystemFont(ofSize: 16)
        
        mediaView.layer.cornerRadius = 10
        mediaView.clipsToBounds = true
        
        mediaImageView.contentMode = .scaleAspectFill
        mediaImageView.backgroundColor = .red
        
        gradeTitleLabel.text = "평점"
        gradeTitleLabel.textColor = .white
        gradeTitleLabel.textAlignment = .center
        gradeTitleLabel.font = .systemFont(ofSize: 14)
        gradeTitleLabel.backgroundColor = .purple.withAlphaComponent(0.7)
        
        gradeScoreLabel.textColor = .black
        gradeScoreLabel.textAlignment = .center
        gradeScoreLabel.font = .systemFont(ofSize: 14)
        gradeScoreLabel.backgroundColor = .white
        
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 18)
        
        charactersLabel.textColor = .darkGray
        charactersLabel.textAlignment = .left
        charactersLabel.font = .systemFont(ofSize: 14)
        
        dividerView.backgroundColor = .black
        
        detailLabel.text = "자세히 보기"
        detailLabel.textColor = .black
        detailLabel.textAlignment = .left
        detailLabel.font = .systemFont(ofSize: 12)
        
        detailImageView.image = UIImage(systemName: "chevron.right")
    }
    
    func setHierachy() {
        [dateLabel, categoryLabel, mediaView].forEach {
            contentView.addSubview($0)
        }
        
        [mediaImageView, gradeTitleLabel, gradeScoreLabel, titleLabel, charactersLabel, dividerView, detailLabel, detailImageView].forEach {
            mediaView.addSubview($0)
        }
    }
    
    func setConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(16)
        }
        
        mediaView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(mediaView.snp.width)
        }
        
        mediaImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(5 / 3)
        }
        
        gradeTitleLabel.snp.makeConstraints { make in
            make.leading.bottom.equalTo(mediaImageView).inset(16)
            make.width.equalTo(36)
            make.height.equalTo(32)
        }
        
        gradeScoreLabel.snp.makeConstraints { make in
            make.leading.equalTo(gradeTitleLabel.snp.trailing)
            make.bottom.size.equalTo(gradeTitleLabel)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mediaImageView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        charactersLabel.snp.makeConstraints { make in
            make.top.equalTo(mediaImageView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(charactersLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(16)
        }
        
        detailImageView.snp.makeConstraints { make in
            make.centerY.equalTo(detailLabel)
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(35)
        }
    }
}
