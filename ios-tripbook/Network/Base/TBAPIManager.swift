//
//  TBApiService.swift
//  ios-tripbook
//
//  Created by DDang on 6/24/23.
//

import Foundation
import Alamofire

struct TBAPIManager {
    static let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        let interceptor = TBAuthInterceptor()
        let apiLogger = TBAPIEventLogger()
        
        configuration.timeoutIntervalForRequest = 30
        
        return Session(configuration: configuration, interceptor: interceptor, eventMonitors: [apiLogger])
    }()
}
