//
//  RootViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/14.
//

import Foundation
import SwiftUI

/// Root 화면 View Model
/// - Author: 김민규
/// - Date: 2023/05/15
class RootViewModel: ObservableObject {
    /// TabView에 포함된 화면 Views
    enum TabType {
        /// 홈 화면
        case home
        
        /// 여행 기록 화면
        case travelReport
        
        /// 여행 기록 등록 화면
        case registerTravelReport
        
        /// 여행 소식 화면
        case travelNews
        
        /// 내 정보 화면
        case profile
    }
    /// 활성화된 Tab
    @Published var selectedTab: TabType = .home
}
