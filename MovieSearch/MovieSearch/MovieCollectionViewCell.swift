//
//  MovieCollectionViewCell.swift
//  MovieSearch
//
//  Created by 아라 on 6/12/24.
//

import UIKit
import SnapKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieCollectionViewCell"
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 3
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ data: Movie) {
        guard let posterPath = data.posterPath else { return }
        let imageString = "https://image.tmdb.org/t/p/original" + posterPath
        let url = URL(string: imageString)
        imageView.kf.setImage(with: url)
    }
}
