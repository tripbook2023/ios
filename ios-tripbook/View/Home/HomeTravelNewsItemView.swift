//
//  HomeTravelNewsItemView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/13.
//

import SwiftUI

/// Home - 여행 소식 Item View
/// - Author: 김민규
/// - Date: 2023/05/15
struct HomeTravelNewsItemView: View {
    @ObservedObject var viewModel: HomeTravelNewsItemViewModel
    
    init(_ data: TravelNewsModel) {
        self.viewModel = HomeTravelNewsItemViewModel(data)
    }
    
    var body: some View {
        Image(uiImage: self.viewModel.data.image)
            .resizable()
            .scaledToFill()
            .frame(width: 231, height: 349)
            .clipped()
            .overlay(
                VStack(alignment: .leading) {
                    Text(self.viewModel.data.title)
                        .frame(width: 231 / 1.5)
                        .font(.suit(.bold, size: 19))
                        .shadow(radius: 4, y: 4)
                        .foregroundColor(.white)
                        .lineLimit(2)
                    Spacer()
                    HStack {
                        Spacer()
                        ToggleButton(
                            image: self.viewModel.data.isSaved ? Image(systemName: "bookmark.fill") : Image(systemName: "bookmark"),
                            imageColor: self.viewModel.data.isSaved ? .yellow : .white,
                            labelColor: .primary,
                            isToggled: self.$viewModel.data.isSaved
                        ) {
                            print("tap")
                        }
                    }
                }.padding(EdgeInsets(top: 9, leading: 19, bottom: 12, trailing: 4))
            )
    }
}

struct HomeTravelNewsItemView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTravelNewsItemView(SampleTravelNewsModel())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
