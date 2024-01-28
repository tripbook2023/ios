//
//  APIManagerable.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/09/18.
//

import Foundation

enum EncodingType {
    case json
    case url
}

protocol APIManagerable {
    func request<T: Decodable>(_ api: APIable, type: T.Type, encodingType: EncodingType) async throws -> T
    @discardableResult
    func request(_ api: APIable, encodingType: EncodingType) async throws -> Data
    
    func upload<T: Decodable>(_ api: APIable, type: T.Type) async throws -> T
    @discardableResult
    func upload(_ api: APIable) async throws -> Data
}
