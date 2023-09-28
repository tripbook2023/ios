//
//  APIManagerable.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/09/18.
//

import Foundation

protocol APIManagerable {
    func request<T: Decodable>(_ api: APIable, type: T.Type) async throws -> T
    func request(_ api: APIable) async throws -> Data
    
    func upload<T: Decodable>(_ api: APIable, type: T.Type) async throws -> T
    func upload(_ api: APIable) async throws -> Data
}
