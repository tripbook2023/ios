//
//  TravelNewsListItemView.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/09/13.
//

import SwiftUI

import Kingfisher

struct TravelNewsListItemView: View {
    @Binding private var item: TravelNewsModel
    private var likeButtonAction: () -> Void
    
    init(
        item: Binding<TravelNewsModel>,
        likeButtonAction: @escaping () -> Void = {}
    ) {
        self._item = item
        self.likeButtonAction = likeButtonAction
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            NavigationLink {
                Text("\(item.title)디테일 화면")
            } label: {
                KFImage(item.thumbnailURL)
                    .resizable()
                    .frame(height: 335)
                    .overlay(TBColor.grayscale._90.opacity(0.4))
            }

            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 4) {
                    TBAvatar(type: .basic, profileImageURL: item.author.profileUrl)
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
                            likeButtonAction()
                        }) {
                            if item.isLiked {
                                TBIcon.like.active.iconSize(size: .medium)
                                    .foregroundColor(.white)
                            } else {
                                TBIcon.like.normal.iconSize(size: .medium)
                                    .foregroundColor(.white)
                            }
                        }

                        Text("\(item.likeCount)")
                            .font(TBFont.caption_1)
                            .foregroundColor(TBColor.grayscale._1)
                    }
                    Spacer()
                }.padding(.top, 16)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
        }
        .frame(width: 335, height: 335)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct TravelNewsListItemView_Previews: PreviewProvider {
    static var previews: some View {
        TravelNewsListItemView(item: .constant(TravelNewsModel.dummy))
    }
}
