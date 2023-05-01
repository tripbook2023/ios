//
//  HomeHeaderView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/01.
//

import SwiftUI

/**
 View: 홈 화면- Header
 */
struct HomeHeaderView: View {
    @State var point: Int
    
    var body: some View {
        HStack {
            Text("Tripbook")
                .font(.custom("NotoSansKR-Bold", size: 18))
            Spacer()
            NavigationLink(destination: HomeSearchView()) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.primary)
            }
            Text("\(point)P")
                .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 18))
                .padding(EdgeInsets(top: 0.0, leading: 18.0, bottom: 0.0, trailing: 18.0))
                .background(Color(red: 255 / 255, green: 231 / 255, blue: 146 / 255))
                .cornerRadius(20.0)
                .foregroundColor(.black)
        }.padding(.horizontal)
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView(point: 1000)
    }
}
