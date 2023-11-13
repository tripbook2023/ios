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
    - MypageView
 */
struct RootView: View {
    @ObservedObject var viewModel = RootViewModel()
    
    var body: some View {
        NavigationView {
            TabView(selection: self.$viewModel.selectedTab) {
                
                TravelNewsView()
                    .tabItem {
                        if viewModel.selectedTab == .home {
                            TBIcon.navigation.home.active
                        } else {
                            TBIcon.navigation.home.normal
                        }
                        
                        Text("홈")
                    }
                    .tag(RootViewModel.TabType.home)
                
                RegisterTravelReportView()
                    .tabItem {
                        if viewModel.selectedTab == .registerTravelReport {
                            TBIcon.navigation.plus.active
                        } else {
                            TBIcon.navigation.plus.normal
                        }
                        
                        Text("등록")
                    }
                    .tag(RootViewModel.TabType.registerTravelReport)
                
                MypageView()
                    .tabItem {
                        if viewModel.selectedTab == .profile {
                            TBIcon.navigation.mypage.active
                        } else {
                            TBIcon.navigation.mypage.normal
                        }
                        
                        Text("내 정보")
                    }
                    .tag(RootViewModel.TabType.profile)
            }.onAppear() {
                UITabBar.appearance().barTintColor = .white
            }
            .accentColor(TBColor.primary._50)
        }.navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
