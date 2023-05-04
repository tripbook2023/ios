//
//  HomeViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/29.
//

import SwiftUI

// 임시: 로그인 상태 분별
enum LoginStateType {
    case login
    case logout
}

// Enum: 홈 화면에 포함되는 View의 타입을 정의
enum HomeViewPropertyType {
    case titleView
    case recommendUserView
    
    case popularTravelReportView
    case preperTravelReportView
    case similarTravelReportView
    
    case eventBannerView
    case leastTravelNewsView
}

/**
 Struct: 홈 화면에 포함되는 View의 타입과 개수를 명시
 Variables:
 - id (UUID): 고유 ID값 (default)
 - type (HomeViewPropertyType): View 타입
 - count (Integer): View의 개수 (default. 1)
 */
struct HomeViewProperty {
    let id = UUID()
    var type: HomeViewPropertyType
    var count: Int = 1
}

/**
 Struct: 홈 화면에 포함되는 소제목(sectionTitle)을 기준으로 분기하여 소제목과 View Property들을 명시
 Variables:
 - id (UUID): 고유 ID값 (default)
 - sectionTitle (String?): 소제목
    - example) 트래블리님, 지금 여행기록 하고 스타벅스 벚꽃라떼 한 잔 어떠세요?
    - example) 홍길동님이 좋아할 만한 여행지에요!
    - 2023/05/01 기준. 피그마 스토리보드에 기재되어 있는 문구.
 - properties (Array<HomeViewProperty>): View Property 리스트
 */
struct HomeViewPropertySection {
    let id = UUID()
    var sectionTitle: String?
    var properties: [HomeViewProperty]
}

/**
 Struct: 홈 화면에 포함되는 Section들을 명시
 Variables:
 - sections (Array<HomeViewPropertySection>): 홈 화면에 포함되는 전체 View 리스트
 */
struct HomeViewProperties {
    var sections: [HomeViewPropertySection]
}

/**
 class: 홈 화면 ViewModel
 variables:
 - loginState (LoginStateType): 회원 로그인 상태
    - 임시 Enum타입으로 추가개발 진행하면서 수정 예정
 - point (Integer): 회원 보유 포인트
 - viewProperties (Dictionary<LoginStateType:HomeViewProperties>): 회원 로그인 상태 별로 Load할 View의 구조도를 미리 정의한다.
 */
class HomeViewModel: ObservableObject {
    
    @Published var loginState: LoginStateType = .login
    
    @Published var point: Int = 1000
    
    let viewProperties: [LoginStateType: HomeViewProperties] = [
        .login: HomeViewProperties(sections: [
            HomeViewPropertySection(
                properties: [
                    HomeViewProperty(type: .titleView),
                    HomeViewProperty(type: .recommendUserView, count: 10),
                    HomeViewProperty(type: .preperTravelReportView, count: 10)
                ]
            ),
            HomeViewPropertySection(
                sectionTitle: "홍길동님이\n좋아할 만한 여행지에요!",
                properties: [
                    HomeViewProperty(type: .similarTravelReportView, count: 1),
                    HomeViewProperty(type: .eventBannerView),
                    HomeViewProperty(type: .leastTravelNewsView)
                ]
            )
        ]),
        .logout: HomeViewProperties(sections: [
            HomeViewPropertySection(
                sectionTitle: "트래블리님, 지금 여행기록 하고\n스타벅스 벚꽃라떼 한 잔 어떠세요?",
                properties: [
                    HomeViewProperty(type: .recommendUserView, count: 10),
                    HomeViewProperty(type: .popularTravelReportView, count: 3),
                    HomeViewProperty(type: .eventBannerView),
                    HomeViewProperty(type: .leastTravelNewsView)
                ]
            )
        ])
    ]
    
    // Function: 홈 화면에 포함되는 View 로드 (without. Header)
    func loadViews() -> some View {
        return VStack(spacing: 0) {
            ForEach(viewProperties[loginState]!.sections, id: \.id) { section in
                // sectionTitle View
                if let title = section.sectionTitle {
                    Text(title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 23))
                        .padding(.horizontal)
                }
                
                ForEach(section.properties, id: \.id) { property in
                    // View Container 사이의 Padding
                    if let index = section.properties.firstIndex(where: {$0.id == property.id}) {
                        if index != 0 || section.sectionTitle != nil {
                            Spacer().frame(height: 24)
                        }
                    }
                    
                    // Property별 View 로드
                    switch property.type {
                    case .titleView:
                        self.loadTitleView()
                    case .recommendUserView:
                        self.loadRecommendUserViews(property)
                    case .popularTravelReportView:
                        self.loadPopularTravelReportViews(property)
                    case .preperTravelReportView:
                        self.loadPreperTravelReportViews(property)
                    case .similarTravelReportView:
                        self.loadSimilarTravelReportViews(property)
                    case .eventBannerView:
                        self.loadEventBannerView()
                    case .leastTravelNewsView:
                        self.loadLeastTravelNewsView()
                    }
                }
                
                // Section 사이의 Padding
                Spacer().frame(height: 36)
            }
        }
    }
}

extension HomeViewModel {
    // Function: HomeTitleView를 로드.
    func loadTitleView() -> some View {
        return HomeTitleView(userName: "홍길동", countOfReports: 1).padding(.horizontal)
    }
    
    // Function: 추천 사용자 리스트를 로드.
    func loadRecommendUserViews(_ property: HomeViewProperty) -> some View {
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<property.count, id: \.self) { _ in
                    Button(action: {
                        
                    }) {
                        VStack {
                            Image("SampleProfileImage")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 74, height: 74)
                                .clipped()
                                .cornerRadius(74 / 2)
                            Text("서지혜")
                                .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 13))
                        }
                    }.foregroundColor(.primary)
                }
            }.padding(.horizontal)
        }
    }
    
    // Function: 인기 여행기록 리스트를 로드.
    func loadPopularTravelReportViews(_ property: HomeViewProperty) -> some View {
        return VStack(spacing: 0) {
            ForEach(0..<property.count, id: \.self) { index in
                if index != 0 {
                    Spacer().frame(height: 30)
                }
                FeedItemView(
                    FeedModel(
                        user: .init(name: "서지혜", profileImage: UIImage(named: "SampleProfileImage")!),
                        image: UIImage(named: "SampleFeedThumbnail")!,
                        likeCount: 1,
                        commentCount: 2,
                        isSaved: false,
                        title: "title",
                        content: "contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent",
                        isLiked: false,
                        createdAt: .init()
                    )
                ).padding(.horizontal)
            }
        }
    }
    
    // Function: 사용자별 선호하는 여행기록 리스트를 로드.
    func loadPreperTravelReportViews(_ property: HomeViewProperty) -> some View {
        return VStack(spacing: 0) {
            ForEach(0..<property.count, id: \.self) { index in
                if index != 0 {
                    Spacer().frame(height: 30)
                }
                FeedItemView(
                    FeedModel(
                        user: .init(name: "서지혜", profileImage: UIImage(named: "SampleProfileImage")!),
                        image: UIImage(named: "SampleFeedThumbnail")!,
                        likeCount: 1,
                        commentCount: 2,
                        isSaved: false,
                        title: "title",
                        content: "contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent",
                        isLiked: false,
                        createdAt: .init()
                    )
                ).padding(.horizontal)
            }
        }
    }
    
    // Function: 사용자별 기록된 여행기록과 유사한 여행기록 리스트를 로드.
    func loadSimilarTravelReportViews(_ property: HomeViewProperty) -> some View {
        return VStack(spacing: 0) {
            ForEach(0..<property.count, id: \.self) { index in
                if index != 0 {
                    Spacer().frame(height: 30)
                }
                FeedItemView(
                    FeedModel(
                        user: .init(name: "서지혜", profileImage: UIImage(named: "SampleProfileImage")!),
                        image: UIImage(named: "SampleFeedThumbnail")!,
                        likeCount: 1,
                        commentCount: 2,
                        isSaved: false,
                        title: "title",
                        content: "contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent",
                        isLiked: false,
                        createdAt: .init()
                    )
                ).padding(.horizontal)
            }
        }
    }
    
    // Function: 이벤트 배너 View를 로드
    func loadEventBannerView() -> some View {
        return EventBannerView().padding(.horizontal)
    }
    
    // Function: 신규 여행소식 View를 로드
    func loadLeastTravelNewsView() -> some View {
        return FeedItemView(
            FeedModel(
                user: .init(name: "서지혜", profileImage: UIImage(named: "SampleProfileImage")!),
                image: UIImage(named: "SampleFeedThumbnail")!,
                likeCount: 1,
                commentCount: 2,
                isSaved: false,
                title: "title",
                content: "contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent",
                isLiked: false,
                createdAt: .init()
            )
        ).padding(.horizontal)
    }
}
