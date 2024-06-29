//
//  SimilarCollectionViewCell.swift
//  Media
//
//  Created by 아라 on 6/24/24.
//

import UIKit
import SnapKit
import Kingfisher

class PosterCollectionViewCell: UICollectionViewCell {
    static let identifier = "PosterCollectionViewCell"
    let imageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .lightGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        contentView.addSubview(imageView)
        
    }
    
    func setLayout() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureCell(data: Movie) {
        guard let posterPath = data.posterPath else { return }
        let imageString = "https://image.tmdb.org/t/p/original/" + posterPath
        guard let url = URL(string: imageString) else { return }
        imageView.kf.setImage(with: url)
    }
    
    func configureCell(data: Poster) {
        let imageString = "https://image.tmdb.org/t/p/original/" + data.filePath
        guard let url = URL(string: imageString) else { return }
        imageView.kf.setImage(with: url)
    }
}
