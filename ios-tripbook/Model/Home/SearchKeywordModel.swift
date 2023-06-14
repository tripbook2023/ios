//
//  SearchKeywordModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/27.
//

import Foundation

protocol SearchKeywordModel {
    var name: String { get set }
}

struct TravelReportSearchKeywordModel: SearchKeywordModel {
    var name: String
}
