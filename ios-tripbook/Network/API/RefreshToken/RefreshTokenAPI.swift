//
//  RefreshTokenAPI.swift
//  ios-tripbook
//
//  Created by 이시원 on 12/5/23.
//

import Foundation

import Alamofire

struct RefreshTokenAPI: APIable {
    var baseURL: String = TBAPIPath.base
    var path: String = TBAPIPath.Member.tokenIssue
    var method: HTTPMethod = .post
    var parameters: Parameters = [:]
    var headers: HTTPHeaders
    var uploadImages: [String : [Data?]] = [:]
    
    static func refreshToken(_ refreshToken: String) async throws -> TokenReissueResponse {
        var headers = HTTPHeaders()
        headers.add(.authorization(bearerToken: refreshToken))
        headers.add(.userAgent("IOS_APP"))
        let api =  RefreshTokenAPI(
            headers: headers
        )
        
        guard let url = URL(string: "\(api.baseURL)\(api.path)") else {
            throw TBNetworkError.createURLError
        }
        
        let data = try await AF.request(
            url,
            method: api.method,
            parameters: api.parameters,
            headers: api.headers
        )
        .serializingResponse(using: .data)
        .value
        return try JSONDecoder().decode(TokenReissueResponse.self, from: data)
    }
}
