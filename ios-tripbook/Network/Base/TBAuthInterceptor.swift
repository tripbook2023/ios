//
//  TBAuthInterceptor.swift
//  ios-tripbook
//
//  Created by DDang on 6/24/23.
//

import Foundation
import Alamofire

class TBAuthInterceptor: RequestInterceptor {
    private let retryLimit = 2
    private let retryDelay: TimeInterval = 0
    private var apiManager: APIManagerable
    
    init(apiManager: APIManagerable) {
        self.apiManager = apiManager
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        if let token = TokenStorage.shared.accessToken {
            if urlRequest.headers.dictionary["Authorization"] == nil {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
        }
        
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            return completion(.doNotRetryWithError(error))
        }
        guard request.retryCount < retryLimit else { return completion(.doNotRetryWithError(error)) }
        Task {
            guard let refreshToken = TokenStorage.shared.refreshToken else {
                return completion(.doNotRetryWithError(error))
            }
            do {
                let api = TBMemberAPI.refreshToken(refreshToken)
                let token = try await apiManager.request(api, type: TokenReissueResponse.self)
                TokenStorage.shared.setTokens(accessToken: token.accessToken, refreshToken: token.refreshToken)
                return completion(.retry)
            } catch {
                return completion(.doNotRetryWithError(error))
            }
            
        }
    }
}
