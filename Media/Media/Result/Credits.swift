//
//  People.swift
//  Media
//
//  Created by 아라 on 6/11/24.
//

import Foundation

struct Credits: Codable {
    let id: Int
    let cast: [Cast]
}

struct Cast: Codable, Equatable {
    let id: Int
    let name: String
    let profilePath: String?
    let character: String?
    let department: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
        case character
        case department
    }
}
