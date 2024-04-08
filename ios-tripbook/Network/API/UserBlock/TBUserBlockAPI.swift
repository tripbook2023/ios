//
//  TBUserBlockAPI.swift
//  ios-tripbook
//
//  Created by 이시원 on 4/8/24.
//

import Foundation
import Alamofire

struct TBUserBlockAPI: APIable {
    let baseURL: String = TBAPIPath.base
    let path: String = TBAPIPath.Block
    let method: HTTPMethod
    let parameters: Alamofire.Parameters
    let headers: HTTPHeaders = .init()
    let uploadImages: [String : [Data?]] = [:]
    
    static func getBlocks() -> Self {
        return TBUserBlockAPI(
            method: .get,
            parameters: [:]
        )
    }
    
    static func addBlocks(id: Int) -> Self {
        return TBUserBlockAPI(
            method: .post,
            parameters: [
                "targetIdList" : id
            ]
        )
    }
    
    static func deleteBlocks(id: Int) -> Self {
        return TBUserBlockAPI(
            method: .delete,
            parameters: [
                "targetIdList" : id
            ]
        )
    }
}
