//
//  TBMemberAPI.swift
//  ios-tripbook
//
//  Created by DDang on 6/25/23.
//

import Foundation
import Alamofire

enum TBMemberAPI: APIable {
    case update(request: Requestable)
    case signup(request: Requestable)
    case select
    case nicknameValidate(name: String)
    
    
    var baseURL: String {
        TBAPIPath.base
    }
    
    var path: String {
        switch self {
        case .update:
            return TBAPIPath.Member.update
        case .signup:
            return TBAPIPath.Member.signup
        case .select:
            return TBAPIPath.Member.select
        case .nicknameValidate:
            return TBAPIPath.Member.nicknameValidate
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .update:
            return .post
        case .signup:
            return .post
        case .select:
            return .get
        case .nicknameValidate:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .update(let request):
            return request.parameter
        case .signup(let request):
            return request.parameter
        case .select:
            return [:]
        case .nicknameValidate(let name):
            return ["name": name]
        }
    }
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add(.userAgent("IOS_APP"))
        switch self {
        case .update, .signup:
            headers.add(.contentType("multipart/form-data"))
        case .select, .nicknameValidate:
            break
        }
        return headers
    }
    
}
