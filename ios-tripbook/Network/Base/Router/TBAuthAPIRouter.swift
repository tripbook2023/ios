//
//  TBAuthAPIRouter.swift
//  ios-tripbook
//
//  Created by DDang on 7/1/23.
//

import Foundation
import Alamofire

class TBAuthAPIRouter: URLRequestConvertible {
    var url = "http://13.124.98.251:9000"
    
    var path: String
    var httpMethod: HTTPMethod
    var headers: HTTPHeaders
    var apiType: TBAPIRouter.APIType
    
    init(path: String, httpMethod: HTTPMethod? = .get, headers: AuthenticationRequest, apiType: TBAPIRouter.APIType) {
        self.path = path
        self.httpMethod = httpMethod ?? .get
        self.headers = [
            .authorization(bearerToken: headers.accessToken)
        ]
        self.apiType = apiType
    }
    
    func asURLRequest() throws -> URLRequest {
        let fullURL = url + path
        let encodedURL = fullURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        var urlComponent = URLComponents(string: encodedURL)!
        
        var request = try URLRequest(url: urlComponent.url!, method: httpMethod)
        
        request.headers = self.headers
        
        return request
    }
}
