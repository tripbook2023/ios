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
 - 
 */
struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0.0) {
                //View: Header
                HStack {
                    Text("Tripbook")
                        .font(.custom("NotoSansKR-Bold", size: 18))
                    Spacer()
                    NavigationLink(destination: HomeSearchView()) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.primary)
                    }
                    Text("1,000P")
                        .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 18))
                        .padding(EdgeInsets(top: 0.0, leading: 18.0, bottom: 0.0, trailing: 18.0))
                        .background(Color(red: 255 / 255, green: 231 / 255, blue: 146 / 255))
                        .cornerRadius(20.0)
                        .foregroundColor(.black)
                }.padding(.horizontal)
                
                Spacer().frame(height: 85.0)
                
                HomeTitleView(isLoggedIn: true).padding(.horizontal)
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(0..<10) { _ in
                            VStack {
                                Image("SampleProfileImage")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 74, height: 74)
                                    .clipped()
                                    .cornerRadius(74 / 2)
                                Text("서지혜")
                                    .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 13))
                            }
                        }
                    }.padding()
                }
                
                Spacer().frame(height: 40)
                
                FeedItemView().padding(.horizontal)
                
                Spacer().frame(height: 30)
                
                EventBannerView().padding(.horizontal)
                
                Spacer().frame(height: 40)
                
                FeedItemView().padding(.horizontal).padding(.bottom)
            }.padding(.bottom)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
