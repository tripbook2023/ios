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
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    @State private var anyCancellable = Set<AnyCancellable>()
    @State private var popView: TBPopup.ViewType? = nil
    
    private var deviceWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: self.$viewModel.selectedTab) {
                TravelNewsView()
                    .environment(\.popupView, $popView)
                    .tabItem {
                        if viewModel.selectedTab == .home {
                            TBIcon.navigation.home.active
                        } else {
                            TBIcon.navigation.home.normal
                        }
                        
                        Text("홈")
                    }
                    .tag(RootViewModel.TabType.home)
                Text("")
                    .tabItem {
                        TBIcon.navigation.plus.normal
                        Text("등록")
                    }
                    .tag(RootViewModel.TabType.register)
                
                MypageView(logoutAction: {
                    viewModel.isShowLogoutMessage = true
                })
                .environment(\.popupView, $popView)
                .tabItem {
                    if viewModel.selectedTab == .profile {
                        TBIcon.navigation.mypage.active
                    } else {
                        TBIcon.navigation.mypage.normal
                    }
                    
                    Text("내 정보")
                }
                .tag(RootViewModel.TabType.profile)
            }
            .onAppear() {
                UITabBar.appearance().backgroundColor = .white
            }
            .accentColor(TBColor.primary._50)
            .navigationBarHidden(true)
            .onChange(of: self.viewModel.selectedTab, perform: { value in
                if self.viewModel.selectedTab == .register {
                    self.viewModel.isPresentRegisterView = true
                } else {
                    self.viewModel.oldSelectedTab = value
                }
            })
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
        }
        .onAppear {
            bind()
            viewModel.dataStorage.getUser()
        }
        .fullScreenCover(
            isPresented: $viewModel.isPresentRegisterView,
            onDismiss: { self.viewModel.selectedTab = self.viewModel.oldSelectedTab },
            content: {
                RegisterTravelNewsView()
        })
        .showAlert(content: $popView)
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
                        viewModel.isShowLogoutMessage = false
                    }
                }
            }
            .store(in: &anyCancellable)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
