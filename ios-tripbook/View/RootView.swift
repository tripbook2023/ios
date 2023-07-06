//
//  ContentView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/06.
//

import SwiftUI

/**
 View: 초기 진입 화면
 
 View 구성 요소
 - TabView
    - HomeView
    - TravelReportView
    - RegisterTravelReportView
    - TravelNewsView
    - ProfileView
 */
struct RootView: View {
    @ObservedObject var viewModel = RootViewModel()
    
    var body: some View {
        NavigationView {
            TabView(selection: self.$viewModel.selectedTab) {
                HomeView(selectedTab: self.$viewModel.selectedTab)
                    .tabItem {
                        Image(systemName: "house")
                        Text("홈")
                    }
                    .tag(RootViewModel.TabType.home)
                
                TravelReportView()
                    .tabItem {
                        Image(systemName: "square.and.pencil")
                        Text("여행기록")
                    }
                    .tag(RootViewModel.TabType.travelReport)
                
                RegisterTravelReportView()
                    .tabItem {
                        Image(systemName: "plus.circle")
                        Text("등록")
                    }
                    .tag(RootViewModel.TabType.registerTravelReport)
                
                TravelNewsView()
                    .tabItem {
                        Image(systemName: "book")
                        Text("여행소식")
                    }
                    .tag(RootViewModel.TabType.travelNews)
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.circle")
                        Text("내 정보")
                    }
                    .tag(RootViewModel.TabType.profile)
            }.accentColor(.primary)
        }.navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
