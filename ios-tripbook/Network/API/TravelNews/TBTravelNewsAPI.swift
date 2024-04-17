//
//  TBTravelNewsAPI.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/09/30.
//

import Foundation
import Alamofire

struct TBTravelNewsAPI: APIable {
    
    var baseURL: String = TBAPIPath.base
    var path: String
    var method: HTTPMethod
    var parameters: Parameters
    var headers: HTTPHeaders
    var uploadImages: [String : [Data?]]
    
    static func search(word: String, page: Int, size: Int, sort: Sort) -> Self {
        return TBTravelNewsAPI(
            path: TBAPIPath.Articles.search,
            method: .get,
            parameters: [
                "word": word,
                "page": page,
                "size": size,
                "sort": sort.rawValue
            ],
            headers: .init(),
            uploadImages: [:]
        )
    }
    
    static func like(id: String) -> Self {
        return TBTravelNewsAPI(
            path: TBAPIPath.Articles.like(id: id),
            method: .post,
            parameters: [:],
            headers: .init(),
            uploadImages: [:]
        )
    }
    
    static func search(id: String) -> Self {
        return TBTravelNewsAPI(
            path: "\(TBAPIPath.Articles.search)/\(id)",
            method: .get,
            parameters: [:],
            headers: .init(),
            uploadImages: [:])
    }
    
    static func delete(id: Int) -> Self {
        return TBTravelNewsAPI(
            path: TBAPIPath.Articles.delete(id: id),
            method: .delete,
            parameters: [:],
            headers: .init(),
            uploadImages: [:]
        )
    }
    
    static func report(id: Int, content: String) -> Self {
        var headers = HTTPHeaders()
        headers.add(.contentType("application/json"))
        return TBTravelNewsAPI(
            path: TBAPIPath.Articles.report,
            method: .post,
            parameters: [
                "articleId": id,
                "content": content
            ],
            headers: headers,
            uploadImages: [:]
        )
    }
    
    static func save(
        saveType: PostSaveType,
        id: Int?,
        title: String,
        content: String,
        nonTagContent: String,
        fileIds: [Int],
        thumbnail: String?,
        locationList: LocationInfo?
    ) -> Self {
        var parameters: [String: Any] = [
            "title": title,
            "content": content,
            "contentOrigin": nonTagContent,
            "fileIds": fileIds
        ]
        if let id = id {
            parameters["articleId"] = id
        }
        if let thumbnail = thumbnail {
            parameters["thumbnail"] = thumbnail
        }
        if let locationList = locationList {
            parameters["locationList"] = [
                [
                    "name": locationList.placeName,
                    "locationX": locationList.x,
                    "locationY": locationList.y
                ]
            ]
        }
        var headers = HTTPHeaders()
        headers.add(.contentType("application/json"))
        return TBTravelNewsAPI(
            path: saveType == .register ? TBAPIPath.Articles.save : TBAPIPath.Articles.temp,
            method: .post,
            parameters: parameters,
            headers: headers,
            uploadImages: [:]
        )
    }
}
