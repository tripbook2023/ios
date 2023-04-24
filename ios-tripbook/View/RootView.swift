//
//  ContentView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/06.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("홈")
                }
            
            TravelReportView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("여행기록")
                }
            
            RegisterTravelReportView()
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("등록")
                }
            
            TravelNewsView()
                .tabItem {
                    Image(systemName: "book")
                    Text("여행소식")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("내 정보")
                }
        }
        .accentColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
