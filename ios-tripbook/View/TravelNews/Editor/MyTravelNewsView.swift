//
//  MyTravelNewsView.swift
//  ios-tripbook
//
//  Created by DDang on 7/13/23.
//

import SwiftUI

struct MyTravelNewsView: View {
    @ObservedObject private var viewModel: TravelNewsViewModel
    @StateObject private var dataStorage: DataStorage = .shared
    
    init(viewModel: TravelNewsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 24) {
            HStack(alignment: .bottom) {
                (Text("\(dataStorage.user?.info?.name ?? "") 님은 여행기록을\n") + Text("\(viewModel.myTravelNewsCount)편 ").foregroundColor(TBColor.primary._50) + Text("작성하셨네요!"))
                    .font(TBFont.heading_2)
                    .foregroundColor(TBColor.grayscale._80)
                
                Spacer()
                
                NavigationLink(destination: MyTravelNewsListView(viewModel: viewModel)) {
                    TBIcon.next.iconSize(size: .medium)
                        .foregroundColor(TBColor.grayscale._70)
                }
            }.padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(viewModel.myTravelNewsList) { item in
                        TravelNewsMiniListItemView(item: item)
                    }
                }.padding(.horizontal, 20)
            }
        }
    }
}

struct TravelNewsEditorListView_Previews: PreviewProvider {
    static var previews: some View {
        MyTravelNewsView(viewModel: TravelNewsViewModel())
    }
}
