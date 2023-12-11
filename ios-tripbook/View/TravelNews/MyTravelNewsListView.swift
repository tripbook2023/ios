//
//  MyTravelNewsListView.swift
//  ios-tripbook
//
//  Created by DDang on 7/16/23.
//

import SwiftUI

struct MyTravelNewsListView: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                TravelNewsEditorListDetailHeaderView()
                TravelNewsMiniListView(items: .constant([
                    TravelNewsModel.dummy,
                    TravelNewsModel.dummy,
                    TravelNewsModel.dummy,
                    TravelNewsModel.dummy
                ]))
            }
        }.navigationBarHidden(true)
    }
}

struct TravelNewsEditorListDetailHeaderView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                TBIcon.before[0].iconSize(size: .medium)
                    .foregroundColor(TBColor.grayscale._90)
            }
            
            Spacer()
            
            Text("여행 소식")
                .font(TBFont.body_3)
                .foregroundColor(TBColor.grayscale._80)
            
            Spacer()
            
            NavigationLink(destination: EmptyView()) {
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
        MyTravelNewsListView()
    }
}
