//
//  HomeTravelNewsItemViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/14.
//

import Foundation

/// Home - 여행 소식 Item View -  View Model
class HomeTravelNewsItemViewModel: ObservableObject {
    /// 여행 소식 Data Model
    @Published var data: TravelNewsModel
    
    /// Home - 여행 소식 Item View -  View Model Initializer
    /// - Parameters:
    ///     - data: 여행 소식 Data Model
    init(_ data: TravelNewsModel) {
        self.data = data
    }
}
