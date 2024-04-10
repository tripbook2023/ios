//
//  TBAPIPath.swift
//  ios-tripbook
//
//  Created by DDang on 6/25/23.
//

import Foundation

struct TBAPIPath {
#if DEBUG
    static let base = "http://13.124.98.251:9000"
#else
    static let base = "https://tripbook.link"
#endif
    
    static let Member = TBMemberAPIPath()
    static let Auth = TBAuthAPIPath()
    static let Articles = TBArticlesAPIPath()
    static let Common = TBCommonAPIPath()
    static let Block = "/blocks"
}
