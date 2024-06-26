//
//  MediaTableViewCell.swift
//  Media
//
//  Created by 아라 on 6/10/24.
//

import UIKit
import SnapKit
import Kingfisher

final class MediaTableViewCell: UITableViewCell {
    static let identifier = "MediaTableViewCell"
    
    private let dateLabel = UILabel()
    private let categoryLabel = UILabel()
    private let mediaView = UIView()
    private let mediaImageView = UIImageView()
    private let gradeTitleLabel = UILabel()
    private let gradeScoreLabel = UILabel()
    private let titleLabel = UILabel()
    private let charactersLabel = UILabel()
    private let dividerView = UIView()
    private let detailLabel = UILabel()
    private let detailImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
        setHierachy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(media: MediaDetailResponse, casts: [Cast]) {
        dateLabel.text = media.releaseDate
        
        var category = ""
        for genre in media.genres {
            category += "#\(genre.name) "
        }
        
        var castString = ""
        
        for cast in casts {
            castString += cast.name + ", "
        }
        
        charactersLabel.text = castString
        
        if let imageString = media.backdropPath {
            let urlString = "https://image.tmdb.org/t/p/w500/" + imageString
            guard let url = URL(string: urlString) else { return }
            mediaImageView.kf.setImage(with: url)
        } else {
            mediaImageView.backgroundColor = .lightGray
        }
        
        categoryLabel.text = category
        
        gradeScoreLabel.text = media.voteAverage.formatted()
        
        titleLabel.text = media.title
    }
    
    private func configureView() {
        dateLabel.textColor = .darkGray
        dateLabel.textAlignment = .left
        dateLabel.font = .systemFont(ofSize: 12)
        
        categoryLabel.textColor = .black
        categoryLabel.textAlignment = .left
        categoryLabel.font = .boldSystemFont(ofSize: 16)
        
        mediaView.layer.cornerRadius = 10
        mediaView.clipsToBounds = true
        
        mediaImageView.contentMode = .scaleAspectFill
        
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
        detailImageView.tintColor = .black
    }
    
    private func setHierachy() {
        [dateLabel, categoryLabel, mediaView].forEach {
            contentView.addSubview($0)
        }
        
        [mediaImageView, gradeTitleLabel, gradeScoreLabel, titleLabel, charactersLabel, dividerView, detailLabel, detailImageView].forEach {
            mediaView.addSubview($0)
        }
    }
    
    private func setConstraints() {
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
            make.bottom.equalToSuperview().inset(16)
        }
        
        mediaImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(mediaView).multipliedBy(0.7)
        }
        
        gradeTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(mediaImageView).inset(16)
            make.bottom.equalTo(mediaImageView).offset(-16)
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
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(charactersLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
        }
        
        detailImageView.snp.makeConstraints { make in
            make.centerY.equalTo(detailLabel)
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(20)
        }
    }
}
