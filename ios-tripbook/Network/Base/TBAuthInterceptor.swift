//
//  TBAuthInterceptor.swift
//  ios-tripbook
//
//  Created by DDang on 6/24/23.
//

import Foundation
import Alamofire

class TokenStorage {
    static let shared = TokenStorage()
    
    var accessToken: String?
    var refreshToken: String?
    
    init(accessToken: String? = nil, refreshToken: String? = nil) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        
        if let tokens = UserDefaults.standard.dictionary(forKey: "UserTokens") {
            self.accessToken = tokens["accessToken"] as? String
            self.refreshToken = tokens["refreshToken"] as? String
        }
    }
    
    func setTokens(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        
        UserDefaults.standard.set([
            "accessToken": accessToken,
            "refreshToken": refreshToken
        ], forKey: "UserTokens")
    }
    
    func deleteTokens() {
        UserDefaults.standard.removeObject(forKey: "UserTokens")
        accessToken = nil
        refreshToken = nil
    }
}

class TBAuthInterceptor: RequestInterceptor {
    let retryLimit = 0
    let retryDelay: TimeInterval = 0
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        if let token = TokenStorage.shared.accessToken {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            return completion(.doNotRetryWithError(error))
        }
    }
}
