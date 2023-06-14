//
//  HomeViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/29.
//

import SwiftUI

/// 홈 화면에 포함되는 View의 타입과 개수를 명시
/// - Author: 김민규
/// - Date: 2023/05/01
struct HomeViewProperty {
    /// 고유 ID값
    let id = UUID()
    /// View 타입
    var type: HomeViewPropertyType
    
    /// 홈 화면에 포함되는 View의 타입을 정의
    enum HomeViewPropertyType {
        /// Tooltip View
        case toolTipView
        
        /// 이벤트 배너 View
        case eventBannerView
        
        /// 사용자 자신의 포인트 배너 View
        case myPointBannerView
        
        /// 회원가입 안내 배너 View
        case signupBannerView
    }
}

/// 홈 화면에 포함되는 소제목(sectionTitle)을 기준으로 분기하여 소제목과 View Property들을 명시
/// - Author: 김민규
/// - Date: 2023/05/01
struct HomeViewPropertySection {
    /// 고유 ID값
    let id = UUID()
    /// Section 타입
    let type: HomeViewPropertySectionType
    /// View Property 리스트
    var properties: [HomeViewProperty]?
    
    /// Section 타입 명시
    enum HomeViewPropertySectionType {
        /// 이벤트, ETC Views
        case events
        
        /// 사용자 자신의 여행기록 Views
        /// - Parameters:
        ///   - name: 사용자의 닉네임
        case myTravelReport
        
        /// 여행기록 Views
        case travelReport
        
        /// 여행소식 Views
        case travelNews
        
        /// 서비스 안내 Views
        case services
        
        /// Section 제목
        var title: String? {
            switch self {
            case .myTravelReport: return "최신 여행기록"
            case .travelReport: return "여행기록"
            case .travelNews: return "여행소식"
            case .services: return "트립북과 함께 해요!"
            default: return nil
            }
        }
        
        /// Section 부가 설명
        var description: String? {
            switch self {
            case .travelReport: return "기억하고 싶은 여행 순간을 기록"
            case .travelNews: return "다양한 여행 정보 소식"
            case .services: return "트립북의 다양한 서비스"
            default: return nil
            }
        }
    }
}

/// 홈 화면에 포함되는 Section들을 명시
/// - Author: 김민규
/// - Date: 2023/05/01
struct HomeViewProperties {
    /// 홈 화면에 포함되는 전체 View 리스트
    var sections: [HomeViewPropertySection]
}

/// 홈 화면 ViewModel
/// - Author: 김민규
/// - Date: 2023/05/01
class HomeViewModel: ObservableObject {
    @Published var dataObject: DataObject?
    
    @Binding var selectedTab: RootViewModel.TabType
    
    /// 회원 로그인 상태 별로 Load할 View의 구조도를 미리 정의한다.
    let viewProperties: [Bool: HomeViewProperties] = [
        true: HomeViewProperties(sections: [
            HomeViewPropertySection(
                type: .events,
                properties: [
                    HomeViewProperty(type: .toolTipView),
                    HomeViewProperty(type: .eventBannerView),
                    HomeViewProperty(type: .myPointBannerView)
                ]
            ),
            HomeViewPropertySection(type: .myTravelReport),
            HomeViewPropertySection(type: .travelReport),
            HomeViewPropertySection(type: .travelNews),
            HomeViewPropertySection(type: .services)
        ]),
        false: HomeViewProperties(sections: [
            HomeViewPropertySection(
                type: .events,
                properties: [
                    HomeViewProperty(type: .toolTipView),
                    HomeViewProperty(type: .eventBannerView)
                ]
            ),
            HomeViewPropertySection(type: .travelReport),
            HomeViewPropertySection(type: .travelNews),
            HomeViewPropertySection(type: .services)
        ])
    ]
    
    init(selectedTab: Binding<RootViewModel.TabType>) {
        self._selectedTab = selectedTab
    }
    
    func setup(_ dataObject: DataObject) {
        self.dataObject = dataObject
    }
}

extension HomeViewModel {
    func moveTravelReportTab() {
        self.selectedTab = .travelReport
    }
    
    func moveTravelNewsTab() {
        self.selectedTab = .travelNews
    }
}
