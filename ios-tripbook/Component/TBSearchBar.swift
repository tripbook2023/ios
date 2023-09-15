//
//  TBSearchBar.swift
//  ios-tripbook
//
//  Created by DDang on 7/11/23.
//

import SwiftUI

struct TBSearchBar: View {
    @Binding var searchText: String
    
    let placeholder: String
    
    init(_ searchText: Binding<String>, placeholder: String) {
        self._searchText = searchText
        self.placeholder = placeholder
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                TBIcon.search.iconSize(size: .medium)
                    .foregroundColor(TBColor.grayscale._50)
                TextField(self.placeholder, text: self.$searchText)
                    .font(TBFont.body_4)
                    .foregroundColor(TBColor.grayscale._80)
                
                Spacer()
                
                if !self.searchText.isEmpty {
                    Button(action: {
                        self.searchText = ""
                    }) {
                        TBIcon.clear.iconSize(size: .small)
                        
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            
            Divider()
                .frame(minHeight: 1)
                .overlay(TBColor.grayscale._5)
        }
    }
}

struct TBSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TBSearchBar(.constant(""), placeholder: "여행지를 검색해주세요")
            TBSearchBar(.constant("여행지를 검색해주세요"), placeholder: "여행지를 검색해주세요")
        }.padding()
    }
}
