//
//  Movie.swift
//  MovieSearch
//
//  Created by 아라 on 6/12/24.
//

import Foundation

struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int
}

struct Movie: Codable {
    let posterPath: String?
    let title: String

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title
    }
}
