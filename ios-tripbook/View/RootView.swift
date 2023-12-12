//
//  ContentView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/06.
//

import SwiftUI
import Combine

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
    @StateObject var viewModel = RootViewModel()
    @Binding private var isPresented: Bool
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    @State private var anyCancellable = Set<AnyCancellable>()
    
    private var deviceWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    init( isPresented: Binding<Bool> = .constant(true)) {
        self._isPresented = isPresented
    }
    
    var body: some View {
        ZStack {
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
                
                RegisterTravelNewsView()
                    .tabItem {
                        if viewModel.selectedTab == .registerTravelReport {
                            TBIcon.navigation.plus.active
                        } else {
                            TBIcon.navigation.plus.normal
                        }
                        
                        Text("등록")
                    }
                    .tag(RootViewModel.TabType.registerTravelReport)
                
                MypageView(logoutAction: {
                    viewModel.isShowLogoutMessage = true
                })
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
            .navigationBarHidden(true)
            
            VStack(spacing: 6) {
                Spacer()
                Image("Logout")
                    .resizable()
                    .frame(width: 240, height: 200)
                Text("로그아웃 되었습니다.")
                    .font(TBFont.body_4)
                    .foregroundStyle(TBColor.grayscale._90)
                Text("다음에 또 만나요!")
                    .font(TBFont.caption_1)
                    .foregroundStyle(TBColor.grayscale._60)
                Spacer()
            }
            .frame(width: deviceWidth)
            .background(.white)
            .opacity(viewModel.isShowLogoutMessage ? 1 : 0)
        }.onAppear {
            bind()
            viewModel.dataStorage.getUser()
        }
    }
}

extension RootView {
    private func bind() {
        viewModel.$isShowLogoutMessage
            .filter { $0 }
            .sink { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(Animation.spring().speed(1)) {
                        self.rootPresentationMode.wrappedValue.dismiss()
                        self.isPresented = false
                    }
                }
            }
            .store(in: &anyCancellable)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(isPresented: .constant(true))
    }
}
