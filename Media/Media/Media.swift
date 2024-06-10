//
//  Media.swift
//  Media
//
//  Created by 아라 on 6/10/24.
//

import Foundation

struct MediaResponse: Codable {
    let page: Int
    let results: [Media]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Media: Codable {
    let id: Int
}

struct MediaDetailResponse: Codable {
    let backdropPath, posterPath: String
    let genres: [Genre]
    let overview: String
    let releaseDate: String
    let title: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}
