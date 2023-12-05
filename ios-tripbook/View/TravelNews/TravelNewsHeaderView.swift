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
    @Binding private var isSearch: Bool
    @Binding private var text: String
    @FocusState private var isFocused: Bool
    private var onSubmitEvent: () -> Void
    
    init(
        isSearch: Binding<Bool>,
        searchText: Binding<String>,
        onSubmitEvent: @escaping () -> Void = {}
    ) {
        self._isSearch = isSearch
        self._text = searchText
        self.onSubmitEvent = onSubmitEvent
    }
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack(alignment: .trailing) {
                HStack {
                    Image("Logo/Black")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                    Spacer()
                }
                .opacity(isSearch ? 0 : 1)
                HStack {
                    Button(action: {
                        isFocused = false
                        withAnimation(Animation.spring().speed(2)) {
                            isSearch = false
                        }
                    }, label: {
                        TBIcon.before[0].iconSize(size: .medium)
                            .foregroundStyle(TBColor.grayscale._90)
                    })
                    .opacity(isSearch ? 1 : 0)
                    
                    TextField(
                        isSearch ? "검색어를 입력하세요." : "",
                        text: $text
                    )
                    .focused($isFocused)
                    .onSubmit(self.onSubmitEvent)
                }
                .frame(
                    width: isSearch ? nil : 0
                )
                .background(.white)
            }
            Spacer()
            Button(action: {
                withAnimation(Animation.spring().speed(2)) {
                    isSearch = true
                }
                isFocused = true
                
            }, label: {
                TBIcon.search.iconSize(size: .medium)
                    .foregroundColor(TBColor.grayscale._90)
            })
            if !isSearch {
                NavigationLink(destination: NotificationView()) {
                    TBIcon.bell.iconSize(size: .medium)
                        .foregroundColor(TBColor.grayscale._90)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}


struct TravelNewsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        TravelNewsHeaderView(
            isSearch: .constant(false),
            searchText: .constant("")
        )
    }
}
