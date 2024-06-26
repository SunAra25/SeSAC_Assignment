//
//  NetworkManager.swift
//  Media
//
//  Created by 아라 on 6/26/24.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    typealias MovieHandler = ([Movie]?, String?) -> Void
    typealias PosterHandler = ([Poster]?, String?) -> Void
    
    func movieRequest(api: TMDBAPI, completionHandler: @escaping MovieHandler) {
        guard let endPoint = api.endPoint else { return }
        AF.request(
            endPoint,
            method: api.method,
            headers: api.headers)
        .validate(statusCode: 200..<500)
        .responseDecodable(of: MovieResponse.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value.results, nil)
            case .failure(_):
                completionHandler(nil, "서버 요청에 실패했습니다.")
            }
        }
    }
    
    func posterRequest(api: TMDBAPI, completionHandler: @escaping PosterHandler) {
        guard let endPoint = api.endPoint else { return }
        AF.request(
            endPoint,
            method: api.method,
            headers: api.headers)
        .validate(statusCode: 200..<500)
        .responseDecodable(of: PosterResponse.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value.posters, nil)
            case .failure(_):
                completionHandler(nil, "서버 요청에 실패했습니다.")
            }
        }
    }
}
