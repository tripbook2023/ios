//
//  TravelNewsHeaderView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/16.
//

import SwiftUI

/// 여행 소식 Header View
/// - Author: 김민규
/// - Date: 2023/05/16
struct TravelNewsHeaderView: View {
    var body: some View {
        ZStack {
            HStack {
                Text("여행소식")
                    .font(.custom("NotoSansKR-Bold", size: 15))
            }
            
            HStack {
                Spacer()
                NavigationLink(destination: HomeSearchView()) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.primary)
                }
                NavigationLink(destination: EmptyView()) {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(.primary)
                }
            }.padding(.horizontal)
        }
    }
}

struct TravelNewsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        TravelNewsHeaderView()
    }
}
