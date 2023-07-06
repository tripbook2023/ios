//
//  TravelNewsItemView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/16.
//

import SwiftUI

/// 여행소식 게시물 Item View
/// - Author: 김민규
/// - Date: 2023/05/20
struct TravelNewsItemView: View {
    @ObservedObject var viewModel: TravelNewsItemViewModel
    
    init(_ data: TravelNewsModel) {
        self.viewModel = TravelNewsItemViewModel(data)
    }
    
    var body: some View {
        LazyVStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 52)
                .foregroundColor(.init(red: 243 / 255, green: 243 / 255, blue: 243 / 255))
                .overlay(
                    HStack {
//                        if let profileImage = self.viewModel.data.author.profileImage {
//                            Image(uiImage: profileImage)
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: 38, height: 38)
//                                .clipShape(Circle())
//                        } else {
                            Circle()
                                .frame(width: 38, height: 38)
//                        }
                        
                        Text(self.viewModel.data.author.name)
                            .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 10))
                        
                        Spacer()
                    }.padding(.horizontal)
                )
            
            Rectangle()
                .frame(height: 520)
                .overlay(
                    Image(uiImage: self.viewModel.data.image)
                        .resizable()
                        .scaledToFill()
                )
                .overlay(
                    VStack(alignment: .leading) {
                        Text(self.viewModel.data.title)
                            .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 27))
                            .foregroundColor(.white)
                            .shadow(color: .init(red: 120 / 255, green: 120 / 255, blue: 120 / 255), radius: 1)
                        
                        Spacer()
                        
                        DocumentActionBar(
                            self.$viewModel.data,
                            delegate: self.viewModel,
                            canShare: true,
                            color: .white
                        )
                    }
                        .padding()
                        .background(Color.init(red: 120 / 255, green: 120 / 255, blue: 120 / 255).opacity(0.4))
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

struct TravelNewsItemView_Previews: PreviewProvider {
    static var previews: some View {
        TravelNewsItemView(SampleTravelNewsModel())
            .previewLayout(.sizeThatFits)
            .padding(.all, 13)
    }
}
