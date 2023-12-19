//
//  TBAuthAPI.swift
//  ios-tripbook
//
//  Created by DDang on 7/1/23.
//

import Foundation
import Alamofire

struct TBAuthAPI: APIable {
    var baseURL: String = TBAPIPath.base
    var path: String
    var method: HTTPMethod
    var parameters: Parameters = [:]
    var headers: HTTPHeaders
    var uploadImages: [String : [Data?]] = [:]
    
    static func authentication(accessToken: String) -> Self {
        var headers = HTTPHeaders()
        headers.add(.userAgent("IOS_APP"))
        headers.add(.authorization(bearerToken: accessToken))
        return TBAuthAPI(
            path: TBAPIPath.Auth.authentication,
            method: .get,
            headers: headers
        )
    }
}
