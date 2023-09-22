//
//  TBApiService.swift
//  ios-tripbook
//
//  Created by DDang on 6/24/23.
//

import Foundation
import Alamofire

struct TBAPIManager: APIManagerable {
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
}

// MARK: - Request

extension TBAPIManager {
    func request<T: Decodable>(_ api: APIable, type: T.Type) async throws -> T {
        let data = try await request(api)
        let result = try JSONDecoder().decode(type, from: data)
        
        return result
    }
    
    func request(_ api: APIable) async throws -> Data {
        let dataRequest = try dataRequest(api)
        let result = dataRequest
            .serializingResponse(using: .data)
        
        return try await result.value
    }
    
    private func dataRequest(_ api: APIable) throws -> DataRequest {
        guard let url = URL(string: "\(api.baseURL)/\(api.path)") else {
            throw TBNetworkError.createURLError
        }
        
        return session.request(
            url,
            method: api.method,
            parameters: api.parameters,
            encoding: JSONEncoding.default,
            headers: api.headers
        ).validate(statusCode: 200..<300)
    }
}

// MARK: - Upload

extension TBAPIManager {
    func upload<T: Decodable>(_ api: APIable, type: T.Type
    ) async throws -> T {
        let data = try await upload(api)
        let result = try JSONDecoder().decode(type, from: data)
        
        return result
    }
    
    func upload(_ api: APIable) async throws -> Data {
        let dataRequest = try uploadRequest(api)
        let result = dataRequest
            .serializingResponse(using: .data)
        
        return try await result.value
    }
    
    private func uploadRequest(_ api: APIable) throws -> UploadRequest {
        guard let url = URL(string: "\(api.baseURL)/\(api.path)") else {
            throw TBNetworkError.createURLError
        }
        
        return session.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in api.parameters {
                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }
                for (key, value) in api.uploadImages ?? [:] {
                    value.forEach { image in
                        multipartFormData.append(image, withName: key.rawValue, fileName: "\(image).jpeg", mimeType: "image/jpeg")
                    }
                }

            },
            to: url,
            usingThreshold: .init(),
            headers: api.headers
        ).validate(statusCode: 200..<300)
    }
}
