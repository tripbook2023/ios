//
//  KakaoLocationSearchAPI.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/10/12.
//

import Foundation
import Alamofire

struct KakaoLocationSearchAPI: APIable {
    var baseURL: String = "https://dapi.kakao.com/v2"
    var path: String
    var method: HTTPMethod
    var parameters: Parameters
    var headers: HTTPHeaders
    var uploadImages: [String : [Data?]] = [:]
    
    static func locationSearch(query: String) -> Self {
        var headers = HTTPHeaders()
        headers.add(.authorization("KakaoAK \(Bundle.main.kakaoAPIKey)"))
        headers.add(.contentType("application/json"))
        return .init(
            path: "/local/search/keyword.json",
            method: .get,
            parameters: ["query": query],
            headers: headers
        )
    }
}
