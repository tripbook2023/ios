//
//  TravelNewsView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/24.
//

import SwiftUI

/// 여행 소식 화면
/// - Author: 김민규
/// - Date: 2023/05/20
struct TravelNewsView: View {
    /// Data Manager
    @EnvironmentObject var dataObject: DataObject
    
    @ObservedObject var viewModel = TravelNewsViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                TravelNewsHeaderView()
                
                TabView {
                    ForEach(0..<3, id: \.self) { _ in
                        NavigationLink(destination: RequestEditorView()) {
                            EventBannerView(text: "여행소식 에디터 신청하고 포폴 만들자!").padding(.horizontal)
                        }
                    }
                }
                .frame(height: 110)
                .padding(.top, 47)
                .tabViewStyle(.page)
                
                self.loadAdditionalEditorView()
                
                Spacer().frame(height: 25)
                
                self.loadTravelNewsListView()
            }.padding(.bottom)
        }.onAppear {
            self.viewModel.setup(self.dataObject)
        }
    }
    
    /// 에디터 / 관리자 전용 View
    @ViewBuilder
    func loadAdditionalEditorView() -> some View {
        if self.dataObject.user?.authority == .editor || self.dataObject.user?.authority == .manager {
            VStack {
                HStack(alignment: .bottom) {
                    (
                        Text("\(self.dataObject.user?.name ?? "") 님은 여행기록을\n") +
                        Text("3편 ")
                            .foregroundColor(.init(red: 255 / 255, green: 78 / 255, blue: 0 / 255)) +
                        Text("작성하셨네요!")
                    ).font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 19))
                    
                    Spacer()
                    
                    HStack(spacing: 3) {
                        Text("새 여행기록 작성하기")
                            .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 13))
                            .underline()
                            .foregroundColor(.init(red: 255 / 255, green: 78 / 255, blue: 0 / 255))
                        
                        Image(systemName: "pencil.line")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 11)
                            .foregroundColor(.black)
                            .padding(.all, 4)
                            .background(Circle().foregroundColor(.init(red: 255 / 255, green: 228 / 255, blue: 216 / 255)))
                    }
                }.padding(.horizontal)
                
                Spacer().frame(height: 25)
                
                VStack(spacing: 23) {
                    self.loadMyTravelNewsListView(status: .done)
                    
                    self.loadMyTravelNewsListView(status: .waiting)
                }
            }.padding(.top, 29)
        }
    }
    
    /// 에디터/관리자 본인 여행소식 게시물 List View
    @ViewBuilder
    func loadMyTravelNewsListView(status: MyTravelNewsModel.Status) -> some View {
        let list = self.viewModel.myTravelNewsList.filter({ $0.status == status })
        let count = list.count
        
        if count > 0 {
            VStack(alignment: .leading, spacing: 10) {
                if status == .waiting {
                    Text("승인대기중 \(count)건")
                        .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 19))
                        .padding(.horizontal)
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 13) {
                        ForEach(list, id: \.id) { data in
                            MyTravelNewsItemView(data)
                        }
                    }.padding(.horizontal)
                }
            }
        }
    }
    
    /// 여행소식 게시물 List View
    @ViewBuilder
    func loadTravelNewsListView() -> some View {
        VStack(spacing: 23) {
            ForEach(self.viewModel.travelNewsList, id: \.id) { news in
                TravelNewsItemView(news)
            }
        }.padding(.horizontal)
        
    }
}

struct TravelNewsView_Previews: PreviewProvider {
    static var previews: some View {
        TravelNewsView()
    }
}
