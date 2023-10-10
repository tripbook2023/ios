//
//  TravelNewsListItemView.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/09/13.
//

import SwiftUI

struct TravelNewsListItemView: View {
    private let item: TravelNewsModel
    
    init(item: TravelNewsModel) {
        self.item = item
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(uiImage: item.image)
                .resizable()
                .frame(height: 335)
                .overlay(TBColor.grayscale._90.opacity(0.4))
                .overlay(alignment: .top) {
                    HStack(spacing: 0) {
                    }.padding(.top, 12)
                    .padding(.horizontal, 12)
                }
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 4) {
                    TBAvatar(type: .editor)
                    Text(item.author.name)
                        .font(.suit(.medium, size: 12))
                        .foregroundColor(TBColor.grayscale._1)
                }

                Text(item.title)
                    .font(TBFont.heading_2)
                    .foregroundColor(.white)
                    .padding(.top, 8)

                HStack(spacing: 16) {
                    HStack(spacing: 2) {
                        Button(action: {

                        }) {
                            TBIcon.like.iconSize(size: .medium)
                                .foregroundColor(.white)
                        }

                        Text("\(item.likeCount)")
                            .font(TBFont.caption_1)
                            .foregroundColor(TBColor.grayscale._1)
                    }

                    HStack(spacing: 2) {
                        Button(action: {

                        }) {
                            TBIcon.comment.iconSize(size: .medium)
                                .foregroundColor(.white)
                        }

                        Text("\(item.commentCount)")
                            .font(TBFont.caption_1)
                            .foregroundColor(TBColor.grayscale._1)
                    }
                    Spacer()
                }.padding(.top, 16)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
        }.clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct TravelNewsListItemView_Previews: PreviewProvider {
    static var previews: some View {
        TravelNewsListItemView(item: SampleTravelNewsModel())
    }
}
