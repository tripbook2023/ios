//
//  TBSignupAPIRouter.swift
//  ios-tripbook
//
//  Created by DDang on 7/2/23.
//

import Foundation
import Alamofire

class TBSignupAPIRouter: URLRequestConvertible {
    var url = "http://13.124.98.251:9000"
    
    var path: String
    var httpMethod: HTTPMethod
    var multipartFormData: MultipartFormData
    var apiType: TBAPIRouter.APIType
    
    init(path: String, httpMethod: HTTPMethod? = .post, multipartFormData: MultipartFormData, apiType: TBAPIRouter.APIType) {
        self.path = path
        self.httpMethod = httpMethod ?? .post
        self.multipartFormData = multipartFormData
        self.apiType = apiType
    }
    
    func asURLRequest() throws -> URLRequest {
        let fullURL = url + path
        let encodedURL = fullURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        var urlComponent = URLComponents(string: encodedURL)!
        
        var request = try URLRequest(url: urlComponent.url!, method: httpMethod)
        
        return request
    }
}
