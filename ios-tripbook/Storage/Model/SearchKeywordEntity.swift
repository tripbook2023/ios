//
//  SearchKeywordEntity.swift
//  ios-tripbook
//
//  Created by 이시원 on 12/5/23.
//

import Foundation

import RealmSwift

final class SearchKeywordEntity: Object {
    @Persisted private var keyword: String
    @Persisted(primaryKey: true) var id: UUID
    
    convenience init(_ value: String) {
        self.init()
        self.keyword = value
        self.id = UUID()
    }
    
    var toDomain: String {
        return keyword
    }
}
