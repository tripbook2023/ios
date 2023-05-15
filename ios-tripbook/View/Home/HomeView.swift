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
                viewModel.loadViews()
            }.padding(.bottom)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(selectedTab: .constant(.home))
    }
}
