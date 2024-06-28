//
//  Movie.swift
//  Media
//
//  Created by 아라 on 6/24/24.
//

import Foundation

struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movie: Codable {
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
    }
}
