//
//  MovieCollectionViewCell.swift
//  MovieSearch
//
//  Created by 아라 on 6/12/24.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
