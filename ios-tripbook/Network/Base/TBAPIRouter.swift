//
//  TBAPIRouter.swift
//  ios-tripbook
//
//  Created by DDang on 6/25/23.
//

import Foundation
import Alamofire

class TBAPIRouter: URLRequestConvertible {
    enum APIType {
        case auth
        case member
    }
    
    var path: String
    var httpMethod: HTTPMethod
    var parameters: Data?
    var apiType: APIType
    
    init(path: String, httpMethod: HTTPMethod? = .get, parameters: Data? = nil, apiType: APIType) {
        self.path = path
        self.httpMethod = httpMethod ?? .get
        self.parameters = parameters
        self.apiType = apiType
    }
    
    func asURLRequest() throws -> URLRequest {
        let fullURL = "http://152.69.235.171:9000" + path
        let encodedURL = fullURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        var urlComponent = URLComponents(string: encodedURL)!
        
        if httpMethod == .get, let params = parameters {
            if let dictionary = try? JSONSerialization.jsonObject(with: params, options: []) as? [String:Any] {
                var queries = [URLQueryItem]()
                for (name, value) in dictionary {
                    let encodedValue = "\(value)".addingPercentEncodingForRFC3986()
                    let queryItem = URLQueryItem(name: name, value: encodedValue)
                    queries.append(queryItem)
                }
                urlComponent.percentEncodedQueryItems = queries
            }
        }
        
        var request = try URLRequest(url: urlComponent.url!, method: httpMethod)
        
        if httpMethod == .post, let params = parameters {
            request.httpBody = params
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
}

extension String {
    // percent encode by encoding except alphanumeric + unreserved special charcter(-._~/?)
    func addingPercentEncodingForRFC3986() -> String? {
        let unreserved = "-._~/?"
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: unreserved)
        return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
    }
}
