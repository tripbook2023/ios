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
    
    static func search(accessToken: String, word: String, page: Int, size: Int, sort: Sort) -> Self {
        var headers = HTTPHeaders()
        headers.add(.authorization(bearerToken: accessToken))
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
}
