//
//  HomeHeaderView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/01.
//

import SwiftUI

/// Header View
struct HomeHeaderView: View {
    var body: some View {
        HStack {
            Text("Tripbook")
                .font(.custom("NotoSansKR-Bold", size: 18))
            Spacer()
            NavigationLink(destination: HomeSearchView()) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.primary)
            }
            NavigationLink(destination: EmptyView()) {
                Image(systemName: "bell")
                    .foregroundColor(.primary)
            }
        }.padding(.horizontal)
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView()
    }
}
