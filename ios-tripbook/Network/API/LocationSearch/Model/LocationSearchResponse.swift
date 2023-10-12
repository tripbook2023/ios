//
//  LocationSearchResponse.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/10/12.
//

import Foundation

struct LocationSearchResponse: Decodable {
    let locationInfos: [LocationInfoDTO]
    
    enum CodingKeys: String, CodingKey {
        case locationInfos = "documents"
    }
}

struct LocationInfoDTO: Decodable {
    let addressName: String
    let categoryGroupCode: String
    let categoryGroupName: String
    let categoryName: String
    let distance: String
    let id: String
    let phone: String
    let placeName: String
    let placeURL: String
    let roadAddressName: String
    let x: String
    let y: String

    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case categoryGroupCode = "category_group_code"
        case categoryGroupName = "category_group_name"
        case categoryName = "category_name"
        case distance, id, phone
        case placeName = "place_name"
        case placeURL = "place_url"
        case roadAddressName = "road_address_name"
        case x, y
    }
}
