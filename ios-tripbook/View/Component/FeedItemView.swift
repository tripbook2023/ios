//
//  FeedItemView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/26.
//

import SwiftUI

struct FeedItemView: View {
    @ObservedObject var viewModel: FeedItemViewModel
    
    init(_ data: FeedModel) {
        self.viewModel = FeedItemViewModel(data)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 7) {
                Image(uiImage: self.viewModel.data.user.profileImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 38, height: 38)
                    .cornerRadius(38 / 2)
                    .clipped()
                Text(self.viewModel.data.user.name)
                    .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 13))
                Spacer()
            }
            
            Spacer().frame(height: 10)
            
            GeometryReader { geo in
                Image(uiImage: self.viewModel.data.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: 267)
                    .cornerRadius(20.0)
            }.frame(height: 267)
            
            Spacer().frame(height: 10)
            
            HStack(spacing: 20) {
                HStack {
                    Button(action: {
                        self.viewModel.didTapLikeButton()
                    }) {
                        self.viewModel.getLikeButtonConfigure().image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }.foregroundColor(self.viewModel.getLikeButtonConfigure().backgroundColor)
                    if viewModel.data.likeCount != 0 {
                        Text("\(viewModel.data.likeCount)")
                            .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 13))
                    }
                }
                HStack {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "text.bubble")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }.foregroundColor(.primary)
                    if viewModel.data.commentCount != 0 {
                        Text("\(viewModel.data.commentCount)")
                            .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 13))
                    }
                }
                
                Spacer()
                
                Button(action: {
                    self.viewModel.didTapSaveButton()
                }) {
                    self.viewModel.getSaveButtonConfigure().image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }.foregroundColor(self.viewModel.getSaveButtonConfigure().backgroundColor)
            }.padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 7))
            
            Spacer().frame(height: 10)
            
            Text(self.viewModel.data.title)
                .font(.custom(TBFontType.NotoSansKR.medium.rawValue, size: 12))
                .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 7))
            Text(self.viewModel.data.content)
                .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 12))
                .lineLimit(2)
                .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 7))
        }
    }
}

struct FeedItemView_Previews: PreviewProvider {
    static var previews: some View {
        FeedItemView(
            FeedModel(
                user: .init(name: "서지혜", profileImage: UIImage(named: "SampleProfileImage")!),
                image: UIImage(named: "SampleFeedThumbnail")!,
                likeCount: 1,
                commentCount: 2,
                isSaved: false,
                title: "title",
                content: "contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent",
                isLiked: false,
                createdAt: .init()
            )
        )
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
