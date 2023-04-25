//
//  FeedItemView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/26.
//

import SwiftUI

struct FeedItemView: View {
    @State var likeCount = 1
    @State var commentCount = 1
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 7) {
                Image("SampleProfileImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 38, height: 38)
                    .cornerRadius(38 / 2)
                    .clipped()
                Text("서지혜")
                    .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 13))
                Spacer()
            }
            
            Spacer().frame(height: 10)
            
            GeometryReader { geo in
                Image("SampleFeedThumbnail")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: 267)
                    .cornerRadius(20.0)
            }.frame(height: 267)
            
            Spacer().frame(height: 10)
            
            HStack(spacing: 20) {
                HStack {
                    Image(systemName: "heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    if likeCount != 0 {
                        Text("\(likeCount)")
                            .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 13))
                    }
                }
                HStack {
                    Image(systemName: "text.bubble")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    if commentCount != 0 {
                        Text("\(commentCount)")
                            .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 13))
                    }
                }
                
                Spacer()
                
                Image(systemName: "bookmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }.padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 7))
            
            Spacer().frame(height: 10)
            
            Text("title")
                .font(.custom(TBFontType.NotoSansKR.medium.rawValue, size: 12))
                .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 7))
            Text("contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent")
                .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 12))
                .lineLimit(2)
                .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 7))
        }
    }
}

struct FeedItemView_Previews: PreviewProvider {
    static var previews: some View {
        FeedItemView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
