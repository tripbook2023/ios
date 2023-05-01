//
//  HomeView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/24.
//

import SwiftUI

/**
 View: 홈 화면
 
 View 구성 요소
 - Header
 - Body: HomeViewModel 참조.
 */
struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0.0) {
                //View: Header
                HomeHeaderView(point: self.viewModel.point)
                
                Spacer().frame(height: 85.0)
                
                //View: Body
                viewModel.loadViews()
            }.padding(.bottom)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
