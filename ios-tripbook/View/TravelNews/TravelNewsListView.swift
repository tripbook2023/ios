//
//  TravelNewsListView.swift
//  ios-tripbook
//
//  Created by DDang on 7/15/23.
//

import SwiftUI

struct TravelNewsListView: View {
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Text("여행소식")
                    .font(.suit(.bold, size: 20))
                    .foregroundColor(TBColor.grayscale._80)
                Spacer()
                Button(action: {
                    
                }) {
                    TBIcon.filter.iconSize(size: .medium)
                        .foregroundColor(TBColor.grayscale._70)
                }
            }
            
            VStack(spacing: 20) {
                ForEach(0..<3, id: \.self) { _ in
                    TravelNewsListItemView()
                }
            }
        }.padding(.horizontal, 20)
    }
}

struct TravelNewsListItemView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("SampleFeedThumbnail")
                .resizable()
                .frame(height: 335)
                .aspectRatio(1, contentMode: .fill)
                .overlay(LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.85, green: 0.85, blue: 0.85).opacity(0), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.43, green: 0.43, blue: 0.43).opacity(0.25), location: 0.35),
                        Gradient.Stop(color: .black.opacity(0.5), location: 0.92),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0.04),
                    endPoint: UnitPoint(x: 0.5, y: 0.69)
                ))
                .clipShape(RoundedRectangle(cornerRadius: 12.5625))
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 4) {
                    TBAvatar(type: .editor)
                    Text("에디터D")
                        .font(.suit(.medium, size: 12))
                        .foregroundColor(TBColor.grayscale._1)
                }
                
                Text("혼자 가기 좋은\n벚꽃여행지 BEST 5")
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
                        
                        Text("2")
                            .font(TBFont.caption_1)
                            .foregroundColor(TBColor.grayscale._1)
                    }
                    
                    HStack(spacing: 2) {
                        Button(action: {
                            
                        }) {
                            TBIcon.comment.iconSize(size: .medium)
                                .foregroundColor(.white)
                        }
                        
                        Text("57")
                            .font(TBFont.caption_1)
                            .foregroundColor(TBColor.grayscale._1)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        TBIcon.share.iconSize(size: .medium)
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        
                    }) {
                        TBIcon.bookmark.iconSize(size: .medium)
                            .foregroundColor(.white)
                    }
                }.padding(.top, 16)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
        }
    }
}

struct TravelNewsListView_Previews: PreviewProvider {
    static var previews: some View {
        TravelNewsListView()
    }
}
