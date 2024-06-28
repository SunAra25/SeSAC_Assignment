//
//  TMDBAPI.swift
//  Media
//
//  Created by 아라 on 6/26/24.
//

import Foundation
import Alamofire

enum TMDBAPI {
    case similar(id: Int)
    case recommend(id: Int)
    case poster(id: Int)
    
    var headers: HTTPHeaders {
        return ["Authorization" : APIKey.auth]
    }
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/movie/"
    }
    
    var endPoint: URL? {
        switch self {
        case .similar(let id):
            return URL(string: baseURL + "\(id)/similar")
        case .recommend(let id):
            return URL(string: baseURL + "\(id)/recommendations")
        case .poster(let id):
            return URL(string: baseURL + "\(id)/images")
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
}
