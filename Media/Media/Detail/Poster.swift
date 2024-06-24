//
//  Poster.swift
//  Media
//
//  Created by 아라 on 6/24/24.
//

import Foundation

struct PosterResponse: Codable {
    let id: Int
    let posters: [Poster]
}

struct Poster: Codable {
    let filePath: String

    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}
