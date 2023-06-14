//
//  HomeSearchView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/26.
//

import SwiftUI

struct HomeSearchView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel = HomeSearchViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 7.5) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }.foregroundColor(.primary)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    TextField("벚꽃축제여행", text: self.$viewModel.searchKeyword)
                        .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 18))
                }
                .padding(7.5)
                .background(Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255))
                .cornerRadius(5.0)
                
                if !self.viewModel.searchKeyword.isEmpty && self.viewModel.selectedSearchKeyword != nil {
                    Button("취소") {
                        self.viewModel.returnInitState()
                    }
                    .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 16))
                    .foregroundColor(.primary)
                }
            }.padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 14))
            
            if !self.viewModel.searchKeyword.isEmpty && self.viewModel.selectedSearchKeyword != nil {
                Spacer().frame(height: 25)
                
                HStack(spacing: 0) {
                    ForEach(HomeSearchViewModel.SearchResultTabs.allCases, id: \.id) { tab in
                        VStack(spacing: 0) {
                            Button(tab.rawValue) {
                                self.viewModel.selectedResultTab = tab
                            }
                            .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 18))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.primary)
                            
                            if self.viewModel.selectedResultTab == tab {
                                Color.black.frame(height: 2)
                            } else {
                                Spacer().frame(height: 2)
                            }
                        }
                    }
                }
                Color(red: 217 / 255, green: 217 / 255, blue: 217 / 255)
                    .frame(height: 1)
                
                ScrollView {
                    VStack {
                        ForEach(self.viewModel.searchResults[self.viewModel.selectedResultTab]!, id: \.name) { result in
                            HomeSearchKeywordCellView(cellText: result.name)
                        }.padding(.horizontal)
                    }.padding(EdgeInsets(top: 17.0, leading: 0, bottom: 0, trailing: 0))
                }
            } else if !viewModel.searchKeyword.isEmpty {
                Spacer().frame(height: 49)
                
                ScrollView {
                    VStack(spacing: 8.0) {
                        ForEach(self.viewModel.matchSearchKeywords, id: \.name) { keyword in
                            Button(action: {
                                self.viewModel.selectSearchKeyword(keyword: keyword)
                            }) {
                                HomeSearchKeywordCellView(cellText: keyword.name)
                            }.foregroundColor(.primary)
                        }.padding(.horizontal)
                    }
                }
            } else {
                Spacer().frame(height: 27)
                
                HStack(alignment: .bottom) {
                    Text("최근 검색어")
                        .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 15))
                        .foregroundColor(Color(red: 112 / 255, green: 112 / 255, blue: 112 / 255))
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        Text("전체 삭제")
                            .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 13))
                            .foregroundColor(Color(red: 112 / 255, green: 112 / 255, blue: 112 / 255))
                    }
                }.padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 8.0) {
                        ForEach(self.viewModel.recentKeywords, id: \.name) { keyword in
                            Button(action: {
                                self.viewModel.selectSearchKeyword(keyword: keyword)
                            }) {
                                HomeSearchKeywordCellView(cellText: keyword.name)
                            }.foregroundColor(.primary)
                        }.padding(.horizontal)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct HomeSearchView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSearchView()
    }
}
