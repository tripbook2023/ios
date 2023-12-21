//
//  LikeResponse.swift
//  ios-tripbook
//
//  Created by 이시원 on 12/13/23.
//

import Foundation

struct LikeResponse: Codable {
    let id: Int
    let heartNum: Int
    let bookmarkNum: Int
    let heart: Bool
    let bookmark: Bool
}
