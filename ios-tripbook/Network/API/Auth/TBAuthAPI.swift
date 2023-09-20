//
//  TBAuthAPI.swift
//  ios-tripbook
//
//  Created by DDang on 7/1/23.
//

import Foundation
import Alamofire

enum TBAuthAPI: APIable {
    case authentication(accessToken: String)
    
    var baseURL: String {
        TBAPIPath.base
    }
    
    var path: String {
        switch self {
        case .authentication(_):
            return TBAPIPath.Auth.authentication
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .authentication(_):
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .authentication(_):
            return [:]
        }
    }
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        switch self {
        case .authentication(let accessToken):
            headers.add(.userAgent("IOS_APP"))
            headers.add(.authorization(bearerToken: accessToken))
        }
        return headers
    }
}
