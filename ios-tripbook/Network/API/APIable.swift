//
//  APIable.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/09/16.
//

import Alamofire
import Foundation

protocol APIable {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters { get }
    var headers: HTTPHeaders { get }
}

protocol Requestable: Encodable {
    var parameter: [String: Any] { get }
}



