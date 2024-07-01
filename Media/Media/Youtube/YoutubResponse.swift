//
//  YoutubResponse.swift
//  Media
//
//  Created by 아라 on 7/1/24.
//

import Foundation

struct YoutubResponse: Codable {
    let id: Int
    let results: [Youtube]
}

struct Youtube: Codable {
    let key: String
}
