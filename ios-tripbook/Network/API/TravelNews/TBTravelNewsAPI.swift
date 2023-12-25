//
//  TBTravelNewsAPI.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/09/30.
//

import Foundation
import Alamofire

struct TBTravelNewsAPI: APIable {
    var baseURL: String = TBAPIPath.base
    var path: String
    var method: HTTPMethod
    var parameters: Parameters
    var headers: HTTPHeaders
    var uploadImages: [String : [Data?]]
    
    static func search(word: String, page: Int, size: Int, sort: Sort) -> Self {
        var headers = HTTPHeaders()
        return TBTravelNewsAPI(
            path: TBAPIPath.Articles.search,
            method: .get,
            parameters: [
                "word": word,
                "page": page,
                "size": size,
                "sort": sort.rawValue
            ],
            headers: headers,
            uploadImages: [:]
        )
    }
    
    static func like(id: Int) -> Self {
        return TBTravelNewsAPI(
            path: TBAPIPath.Articles.like(id: id),
            method: .post,
            parameters: [:],
            headers: .init(),
            uploadImages: [:]
        )
    }
    static func search(id: String) -> Self {
        var headers = HTTPHeaders()
        return TBTravelNewsAPI(
                    path: "\(TBAPIPath.Articles.search)/\(id)",
                    method: .get,
                    parameters: [:],
                    headers: headers,
                    uploadImages: [:])
    }
}
