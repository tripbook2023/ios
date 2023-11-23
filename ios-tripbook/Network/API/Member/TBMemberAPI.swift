//
//  TBMemberAPI.swift
//  ios-tripbook
//
//  Created by DDang on 6/25/23.
//

import Foundation
import Alamofire

struct TBMemberAPI: APIable {
    var baseURL: String = TBAPIPath.base
    var path: String
    var method: HTTPMethod
    var parameters: Parameters
    var headers: HTTPHeaders
    var uploadImages: [String : [Data?]]
    
    static func update(accessToken: String, name: String?, images: [String : [Data?]]) -> Self {
        var headers = HTTPHeaders()
        headers.add(.authorization(bearerToken: accessToken))
        headers.add(.contentType("multipart/form-data"))
        return TBMemberAPI(
            path: TBAPIPath.Member.update,
            method: .post,
            parameters: ["name": name as Any],
            headers: headers,
            uploadImages: images
        )
    }
    
    static func signup(request: Requestable, images: [String : [Data?]]) -> Self {
        var headers = HTTPHeaders()
        headers.add(.userAgent("IOS_APP"))
        headers.add(.contentType("multipart/form-data"))
        return TBMemberAPI(
            path: TBAPIPath.Member.signup,
            method: .post,
            parameters: request.parameter,
            headers: headers,
            uploadImages: images
        )
    }
    
    static func select(token: String) -> Self {
        var headers = HTTPHeaders()
        headers.add(.authorization(bearerToken: token))
        return TBMemberAPI(
            path: TBAPIPath.Member.select,
            method: .get,
            parameters: [:],
            headers: headers,
            uploadImages: [:]
        )
    }
    
    static func nicknameValidate(name: String) -> Self {
        let headers = HTTPHeaders()
        return TBMemberAPI(
            path: TBAPIPath.Member.nicknameValidate,
            method: .get,
            parameters: ["name": name.addingPercentEncodingForRFC3986() as Any],
            headers: headers,
            uploadImages: [:]
        )
    }
    
    static func tokenReissue(refreshToken: String) -> Self {
        var headers = HTTPHeaders()
        headers.add(.authorization(bearerToken: refreshToken))
        headers.add(.userAgent("IOS_APP"))
        return TBMemberAPI(
            path: TBAPIPath.Member.tokenIssue,
            method: .post,
            parameters: [:],
            headers: headers,
            uploadImages: [:]
        )
    }
    
    
}

private extension String {
    // percent encode by encoding except alphanumeric + unreserved special charcter(-._~/?)
    func addingPercentEncodingForRFC3986() -> String? {
        let unreserved = "-._~/?"
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: unreserved)
        return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
    }
}
