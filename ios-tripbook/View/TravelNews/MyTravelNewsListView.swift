//
//  MyTravelNewsListView.swift
//  ios-tripbook
//
//  Created by DDang on 7/16/23.
//

import SwiftUI

struct MyTravelNewsListView: View {
    @ObservedObject var viewModel: TravelNewsViewModel
    @State private var isAppear = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                TravelNewsEditorListDetailHeaderView()
                TravelNewsMiniListView(items: $viewModel.myTravelNewsList) { index in
                    if index > viewModel.myTravelNewsList.count - 6 {
                        viewModel.fetchMyTravelNewsList(count: 20, type: .next)
                    }
                }
                .refreshable {
                    viewModel.fetchMyTravelNewsList(count: 20, type: .first)
                }
            }
        }
        .onAppear {
            guard !isAppear else { return }
            isAppear = true
            viewModel.fetchMyTravelNewsList(count: 20, type: .first)
        }
        .navigationBarHidden(true)
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
        }
        .overlay(content: {
            Text("여행 소식")
                .font(TBFont.body_3)
                .foregroundColor(TBColor.grayscale._80)
        })
        .frame(height: 48)
        .padding(.horizontal, 20)
    }
}

struct TravelNewsEditorListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MyTravelNewsListView(viewModel: .init())
    }
}
