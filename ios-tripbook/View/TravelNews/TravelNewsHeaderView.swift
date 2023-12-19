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
    @Binding private var isSearching: Bool
    @Binding private var isSearched: Bool
    @Binding private var text: String
    @FocusState private var isFocused: Bool
    private var onSubmitEvent: () -> Void
    
    init(
        isSearching: Binding<Bool>,
        isSearched: Binding<Bool>,
        searchText: Binding<String>,
        onSubmitEvent: @escaping () -> Void = {}
    ) {
        self._isSearching = isSearching
        self._isSearched = isSearched
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
                .opacity(isSearching ? 0 : 1)
                HStack {
                    Button(action: {
                        isFocused = false
                        withAnimation(Animation.spring().speed(2)) {
                            isSearching = false
                            isSearched = false
                        }
                    }, label: {
                        TBIcon.before[0].iconSize(size: .medium)
                            .foregroundStyle(TBColor.grayscale._90)
                    })
                    .opacity(isSearching ? 1 : 0)
                    
                    TextField(
                        isSearching ? "검색어를 입력하세요." : "",
                        text: $text
                    )
                    .focused($isFocused)
                    .onTapGesture {
                        isSearched = false
                    }
                    .onSubmit(self.onSubmitEvent)
                }
                .frame(
                    width: isSearching ? nil : 0
                )
                .background(.white)
            }
            Spacer()
            if !text.isEmpty {
                Button(action: {
                    text = ""
                    isSearched = false
                    isFocused = true
                }, label: {
                    ZStack {
                        Circle()
                            .foregroundColor(TBColor.grayscale._20)
                            
                        TBIcon.cancel.iconSize(size: .tiny)
                            .foregroundColor(.white)
                    }
                    .frame(width: 20, height: 20)
                })
            }
            
            
            Button(action: {
                withAnimation(Animation.spring().speed(2)) {
                    isSearching = true
                }
                isFocused = true
                
            }, label: {
                TBIcon.search.iconSize(size: .medium)
                    .foregroundColor(TBColor.grayscale._90)
            })
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}


struct TravelNewsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TravelNewsHeaderView(
                isSearching: .constant(false),
                isSearched: .constant(false),
                searchText: .constant("")
            )
            
            TravelNewsHeaderView(
                isSearching: .constant(true),
                isSearched: .constant(false),
                searchText: .constant("sss")
            )
        }
        
    }
}
