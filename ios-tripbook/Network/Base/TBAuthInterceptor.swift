//
//  TBAuthInterceptor.swift
//  ios-tripbook
//
//  Created by DDang on 6/24/23.
//

import Foundation
import Alamofire

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
        Task {
            guard let refreshToken = TokenStorage.shared.refreshToken else {
                return completion(.doNotRetryWithError(error))
            }
            do {
                let token = try await RefreshTokenAPI.refreshToken(refreshToken)
                TokenStorage.shared.setTokens(accessToken: token.accessToken, refreshToken: token.refreshToken)
                return completion(.retry)
            } catch {
                return completion(.doNotRetryWithError(error))
            }
            
        }
    }
}
