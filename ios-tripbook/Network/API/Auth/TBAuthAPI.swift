//
//  TBAuthAPI.swift
//  ios-tripbook
//
//  Created by DDang on 7/1/23.
//

import Foundation
import Alamofire

struct TBAuthAPI {
    static func authentication(_ headers: AuthenticationRequest, completion: @escaping (AuthenticationResult) -> Void) {
        let router = TBAuthAPIRouter(path: TBAPIPath.Auth.authentication, headers: headers, apiType: .auth)
        
        TBAPIManager.shared.sessionManager.request(router).responseDecodable(of: AuthenticationResponse.self, completionHandler: { response in
            switch response.result {
            case .success(let value):
                TokenStorage.shared.accessToken = value.accessToken
                
                completion(value.toDomain)
            case .failure(let error):
                print("authentication Error: \(error)")
                break
            }
        })
    }
}
