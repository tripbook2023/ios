//
//  TravelNewsSortViewModel.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/10/05.
//

import Foundation

enum Sort: String {
    case createdDesc = "createdDesc"
    case createdAsc = "createdAsc"
    case popularity = "popularity"
}

class TravelNewsSortViewModel: ObservableObject {
    @Published var currentSort: Sort = .createdDesc
}
