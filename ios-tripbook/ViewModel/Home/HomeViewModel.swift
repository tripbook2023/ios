//
//  HomeViewModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/29.
//

import SwiftUI

/// 임시: 로그인 상태 분별
/// - Author: 김민규
/// - Date: 2023/05/01
enum LoginStateType {
    case login
    case logout
}

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
        case myTravelReport(String)
        
        /// 여행기록 Views
        case travelReport
        
        /// 여행소식 Views
        case travelNews
        
        /// 서비스 안내 Views
        case services
        
        /// Section 제목
        var title: String? {
            switch self {
            case .myTravelReport(let name): return "\(name)님의 최신 여행기록"
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
    
    @Binding var selectedTab: RootViewModel.TabType
    
    // - TODO: 임시 Enum타입으로 추가개발 진행하면서 수정 예정
    /// 회원 로그인 상태
    @Published var loginState: LoginStateType = .login
    
    init(selectedTab: Binding<RootViewModel.TabType>) {
        self._selectedTab = selectedTab
    }
    
    /// 회원 로그인 상태 별로 Load할 View의 구조도를 미리 정의한다.
    let viewProperties: [LoginStateType: HomeViewProperties] = [
        .login: HomeViewProperties(sections: [
            HomeViewPropertySection(
                type: .events,
                properties: [
                    HomeViewProperty(type: .toolTipView),
                    HomeViewProperty(type: .eventBannerView),
                    HomeViewProperty(type: .myPointBannerView)
                ]
            ),
            HomeViewPropertySection(type: .myTravelReport("홍길동")),
            HomeViewPropertySection(type: .travelReport),
            HomeViewPropertySection(type: .travelNews),
            HomeViewPropertySection(type: .services)
        ]),
        .logout: HomeViewProperties(sections: [
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
    
    /// 홈 화면에 포함되는 View 로드 (without. `Header`)
    /// - Returns: 홈 화면에 포함되는 View
    @ViewBuilder
    func loadViews() -> some View {
        VStack(spacing: 0) {
            ForEach(viewProperties[loginState]!.sections, id: \.id) { section in
                VStack(spacing: 0) {
                    // section - title View
                    if let title = section.type.title {
                        Text(title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 23))
                    }
                        
                    // section - sub-title View
                    if let subTitle = section.type.description {
                        Text(subTitle)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 18))
                            .foregroundColor(Color(red: 151 / 255, green: 151 / 255, blue: 151 / 255))
                    }
                }.padding(.horizontal)
                
                switch section.type {
                case .travelReport: self.loadTravelReportViews(count: 5)
                case .myTravelReport: self.loadMyTravelReportViews(count: 2)
                case .travelNews: self.loadTravelNewsViews(count: 10)
                case .services: self.loadServicesViews()
                default: EmptyView()
                }
                
                if let properties = section.properties {
                    Spacer().frame(height: 21)
                    
                    VStack {
                        ForEach(properties, id: \.id) { property in
                            // Property별 View 로드
                            switch property.type {
                            case .toolTipView: self.loadTooltipView()
                            case .eventBannerView: self.loadEventBannerView()
                            case .myPointBannerView: self.loadMyPointBannerView()
                            case .signupBannerView: self.loadEventBannerView()
                            }
                        }
                    }
                }
                
                // Section 사이의 Padding
                Spacer().frame(height: 21)
            }
        }
    }
}

extension HomeViewModel {
    /// 사용자 자신의 여행기록 Views를 로드
    /// - Parameters:
    ///     - count: View의 개수를 정의
    /// - Returns: 사용자 자신의 여행기록 Views
    @ViewBuilder
    func loadMyTravelReportViews(count: Int) -> some View {
        // TODO: - API Service 연동 && Parameter - Count 삭제
        if count <= 0 {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 244)
                .foregroundColor(Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255))
                .overlay(
                    VStack {
                        Text("홍길동님은\n아직 여행기록이\n없어요!")
                            .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 24))
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        Button(action: {}) {
                            VStack(spacing: 5) {
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("지금 바로 작성하기")
                                    .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 18))
                            }
                        }.foregroundColor(Color(red: 255 / 255, green: 78 / 255, blue: 0 / 255))
                    }.padding()
                )
                .padding(.horizontal)
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem()]) {
                    ForEach(0..<count, id: \.self) { _ in
                        HalfTravelReportItemView(
                            SampleTravelReportModel(),
                            type: .information
                        )
                    }
                }.padding(.horizontal)
            }.padding(.top)
        }
    }
    
    
    /// 여행 기록 View를 로드.
    /// - Parameters:
    ///     - count: View의 개수
    /// - Returns: 여행 기록 View
    @ViewBuilder
    func loadTravelReportViews(count: Int) -> some View {
        // TODO: - API Service 연동
        VStack {
            if loginState == .login {
                VStack(alignment: .leading) {
                    Text("최근 본 여행기록")
                        .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 19))
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: [GridItem()]) {
                            ForEach(0..<10, id: \.self) { _ in
                                HalfTravelReportItemView(SampleTravelReportModel())
                            }
                        }.padding(.horizontal)
                    }
                }.padding(.bottom)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(0..<count, id: \.self) { _ in
                        TravelReportItemView(SampleTravelReportModel())
                    }
                }.padding(.horizontal)
            }
            
            Button(action: {
                self.selectedTab = .travelReport
            }) {
                Text("더 많은 여행기록 보기")
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        Rectangle()
                            .foregroundColor(.clear)
                            .border(Color(red: 217 / 255, green: 217 / 255, blue: 217 / 255))
                    )
            }
            .padding()
            .foregroundColor(Color(red: 151 / 255, green: 151 / 255, blue: 151 / 255))
        }.padding(.top)
    }
    
    /// 여행 소식 View를 로드
    /// - Parameters:
    ///     - count: View의 개수
    /// - Returns: 여행 소식 View
    @ViewBuilder
    func loadTravelNewsViews(count: Int) -> some View {
        // TODO: - API Service 연동 && Parameter - Count 삭제
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(0..<count, id: \.self) { _ in
                        HomeTravelNewsItemView(SampleTravelNewsModel())
                    }
                }.padding(.horizontal)
            }
            
            Button(action: {
                self.selectedTab = .travelNews
            }) {
                Text("더 많은 여행소식 보기")
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        Rectangle()
                            .foregroundColor(.clear)
                            .border(Color(red: 217 / 255, green: 217 / 255, blue: 217 / 255))
                    )
            }
            .padding()
            .foregroundColor(Color(red: 151 / 255, green: 151 / 255, blue: 151 / 255))
        }.padding(.top)
    }
    
    /// 서비스 안내 View를 로드
    /// - Returns: 서비스 안내 View
    @ViewBuilder
    func loadServicesViews() -> some View {
        // TODO: - API Service 연동
        VStack {
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2)) {
                Button(action: {}) {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color(red: 255 / 255, green: 228 / 255, blue: 216 / 255))
                        .overlay(
                            VStack {
                                Text("트립북\n인스타그램")
                                    .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 17))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }.padding()
                        )
                        .frame(height: 138)
                }.foregroundColor(.black)
                
                Button(action: {}) {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color(red: 255 / 255, green: 228 / 255, blue: 216 / 255))
                        .overlay(
                            VStack {
                                Text("트립북\n네이버 블로그")
                                    .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 17))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }.padding()
                        )
                        .frame(height: 138)
                }.foregroundColor(.black)
                
                Button(action: {}) {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color(red: 255 / 255, green: 228 / 255, blue: 216 / 255))
                        .overlay(
                            VStack {
                                Text("여행소식\n에디터 신청")
                                    .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 17))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }.padding()
                        )
                        .frame(height: 138)
                }.foregroundColor(.black)
                
                Button(action: {}) {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color(red: 255 / 255, green: 228 / 255, blue: 216 / 255))
                        .overlay(
                            VStack {
                                Text("트립북\n선물샵 구경")
                                    .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 17))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }.padding()
                        )
                        .frame(height: 138)
                }.foregroundColor(.black)
            }.padding(.horizontal)
            
            Button(action: {}) {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 80)
                    .foregroundColor(Color(red: 255 / 255, green: 233 / 255, blue: 233 / 255))
                    .overlay(
                        HStack {
                            Text("Tripbook이 궁금하시다고요?")
                                .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 19))
                                .foregroundColor(Color(red: 255 / 255, green: 78 / 255, blue: 0 / 255))
                            Spacer()
                            Circle()
                                .frame(width: 44, height: 44)
                                .foregroundColor(.white)
                                .overlay(Image(systemName: "chevron.right").foregroundColor(Color(red: 255 / 255, green: 78 / 255, blue: 0 / 255)))
                        }.padding()
                    )
                    .padding(.horizontal)
            }
        }.padding(.top)
    }
    
    /// Tooltip View를 로드
    /// - Returns: Tooltip View
    @ViewBuilder
    func loadTooltipView() -> some View {
        // TODO: - API Service 연동
        let travelReportsCountToday = 1000
        
        let numberFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
        
        TooltipView(
            "오늘 여행기록 수 \(numberFormatter.string(from: NSNumber(value: travelReportsCountToday))!)건",
            delayMilliseconds: 3000,
            animationSpeed: 1
        ).padding(.horizontal)
    }
    
    /// 이벤트 배너 View를 로드
    /// - Returns: 이벤트 배너 View
    @ViewBuilder
    func loadEventBannerView() -> some View {
        // TODO: - API Service 연동
        TabView {
            ForEach(0..<3, id: \.self) { _ in
                EventBannerView(text: "여행기록하고 굿즈 받자!") {
                    // TODO: - Required To Add Event Banner Click Event
                }.padding(.horizontal)
            }
        }.frame(height: 110).tabViewStyle(.page)
    }
    
    /// 사용자 자신의 포인트 배너 View를 로드
    /// - Returns: 사용자 자신의 포인트 배너 View
    @ViewBuilder
    func loadMyPointBannerView() -> some View {
        // TODO: - API Service 연동
        var name = "홍길동"
        var point = 1000
        
        HomePointBannerView(name: name, point: point).padding(.horizontal)
    }
}
