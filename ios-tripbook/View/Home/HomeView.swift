//
//  HomeView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/24.
//

import SwiftUI

/**
 홈 화면
 
 View 구성 요소
 - Header
 - Body: HomeViewModel 참조.
 */
struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    init(selectedTab: Binding<RootViewModel.TabType>) {
        self.viewModel = HomeViewModel(selectedTab: selectedTab)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0.0) {
                // Header
                HomeHeaderView()
                
                Spacer().frame(height: 28)
                
                // Body
                self.loadViews()
            }.padding(.bottom)
        }
    }
    
    /// 홈 화면에 포함되는 View 로드 (without. `Header`)
    /// - Returns: 홈 화면에 포함되는 View
    @ViewBuilder
    func loadViews() -> some View {
        VStack(spacing: 0) {
            ForEach(self.viewModel.viewProperties[self.viewModel.dataStorage.user != nil]!.sections, id: \.id) { section in
                LazyVStack(spacing: 0) {
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
                    
                    LazyVStack {
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

extension HomeView {
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
                        Text("\(self.viewModel.dataStorage.user?.info?.name ?? "")님은\n아직 여행기록이\n없어요!")
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
            if self.viewModel.dataStorage.user != nil {
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
            
            Button(action: self.viewModel.moveTravelReportTab) {
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
            
            Button(action: self.viewModel.moveTravelNewsTab) {
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
                EventBannerView(text: "여행기록하고 굿즈 받자!").padding(.horizontal)
            }
        }.frame(height: 110).tabViewStyle(.page)
    }
    
    /// 사용자 자신의 포인트 배너 View를 로드
    /// - Returns: 사용자 자신의 포인트 배너 View
    @ViewBuilder
    func loadMyPointBannerView() -> some View {
        // TODO: - API Service 연동
        var point = 1000
        
        HomePointBannerView(name: .constant(self.viewModel.dataStorage.user?.info?.name ?? ""), point: .constant(point)).padding(.horizontal)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(selectedTab: .constant(.home))
    }
}
