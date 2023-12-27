//
//  TBCommonAPI.swift
//  ios-tripbook
//
//  Created by RED on 2023/12/27.
//

import Foundation
import Alamofire

struct TBCommonAPI: APIable {
    var baseURL: String = TBAPIPath.base
    var path: String
    var method: HTTPMethod
    var parameters: Parameters
    var headers: HTTPHeaders
    var uploadImages: [String : [Data?]]
    
    static func upload(image: Data) -> Self {
        var headers = HTTPHeaders()
        return TBCommonAPI(
            path: TBAPIPath.Common.imageUpload,
            method: .post,
            parameters: [:],
            headers: headers,
            uploadImages: ["image": [image]]
        )
    }
}

