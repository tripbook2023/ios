//
//  TravelNewsEditorListDetailView.swift
//  ios-tripbook
//
//  Created by DDang on 7/16/23.
//

import SwiftUI

struct TravelNewsEditorListDetailView: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                TravelNewsEditorListDetailHeaderView()
                
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 11, alignment: .trailing),
                        GridItem(.flexible(), spacing: 11, alignment: .leading)
                    ], spacing: 11, content: {
                        ForEach(0..<16, id: \.self) { _ in
                            TravelNewsEditorListItemView()
                        }
                    }).padding(.vertical, 25)
                }
            }
            
            Button(action: {
                
            }) {
                Circle().foregroundColor(TBColor.primary._50)
                    .frame(width: 60, height: 60)
                    .shadow(TBShadow._2)
                    .overlay(
                        TBIcon.writing.iconSize(size: .big).foregroundColor(.white)
                    )
            }
            .padding(.trailing, 20)
            .padding(.bottom, 28)
        }
    }
}

struct TravelNewsEditorListDetailHeaderView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                TBIcon.before.iconSize(size: .medium)
                    .foregroundColor(TBColor.grayscale._90)
            }
            
            Spacer()
            
            Text("여행 소식")
                .font(TBFont.body_3)
                .foregroundColor(TBColor.grayscale._80)
            
            Spacer()
            
            NavigationLink(destination: HomeSearchView()) {
                TBIcon.search.iconSize(size: .medium)
                    .foregroundColor(.black)
            }
        }
        .frame(height: 48)
        .padding(.horizontal, 20)
    }
}

struct TravelNewsEditorListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TravelNewsEditorListDetailView()
    }
}
