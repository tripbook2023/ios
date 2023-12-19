//
//  SearchKeywordStorage.swift
//  ios-tripbook
//
//  Created by 이시원 on 12/4/23.
//

import Foundation

import RealmSwift

protocol Storageable {
    func read() -> [String]
    func save(_ value: String) throws
    func delete(index: Int) throws
    func deleteAll() throws
}

final class SearchKeywordStorage: Storageable {
    private let realm = try? Realm()
    private var storage: [String]
    private let items: Results<SearchKeywordEntity>?
    
    init() {
        self.items = realm?.objects(SearchKeywordEntity.self)
        self.storage = items?.map { $0.toDomain } ?? []
    }
    
    func read() -> [String] {
         return storage
    }
    
    func save(_ value: String) throws {
        try realm?.write({
            guard let items = items else { return }
            realm?.add(SearchKeywordEntity(value))
            if items.count > 5 {
                guard let item = items[safe: 0] else { return }
                realm?.delete(item)
            }
            storage = items.map { $0.toDomain }
        })
    }
    
    func delete(index: Int) throws {
        try realm?.write({
            guard let items = items else { return }
            guard let item = items[safe: index] else { return }
            realm?.delete(item)
            storage = items.map { $0.toDomain }
        })
    }
    
    func deleteAll() throws {
        try realm?.write({
            realm?.deleteAll()
            storage = []
        })
    }
}

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
