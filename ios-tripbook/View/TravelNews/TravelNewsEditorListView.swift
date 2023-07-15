//
//  TravelNewsEditorListView.swift
//  ios-tripbook
//
//  Created by DDang on 7/13/23.
//

import SwiftUI
import Kingfisher

struct TravelNewsEditorListView: View {
    var body: some View {
        VStack(spacing: 24) {
            HStack(alignment: .bottom) {
                (Text("홍길동 님은 여행소식을\n") + Text("3편 ").foregroundColor(TBColor.primary._50) + Text("작성하셨네요!"))
                    .font(TBFont.heading_2)
                    .foregroundColor(TBColor.grayscale._80)
                
                Spacer()
                
                NavigationLink(destination: {
                    
                }) {
                    TBIcon.next.iconSize(size: .medium)
                        .foregroundColor(TBColor.grayscale._70)
                }
            }.padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(0..<5, id: \.self) { _ in
                        TravelNewsEditorListItemView()
                    }
                }.padding(.horizontal, 20)
            }
        }
    }
}

struct TravelNewsEditorListItemView: View {
    let processor = ResizingImageProcessor(referenceSize: .init(width: 154, height: 154), mode: .aspectFill)
    
    var body: some View {
        ZStack {
            KFImage.url(.init(string: "https://images.unsplash.com/photo-1502680390469-be75c86b636f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c3VyZmluZ3xlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80"))
                .setProcessor(self.processor)
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .cropping(size: .init(width: 154, height: 154))
                .cornerRadius(12)
            
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(TBColor.grayscale._90.opacity(0.3))
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Spacer()
                    TBTag(.awaitingApproval)
                }
                
                Spacer()
                
                Text("돌아온 여름\n서핑하기 좋은 곳 추천")
                    .font(TBFont.caption_1)
                    .foregroundColor(.white)
                
                Text("2022.06.30")
                    .font(TBFont.caption_2)
                    .foregroundColor(TBColor.grayscale._5)
            }
            .padding(.top, 12)
            .padding(.trailing, 12)
            .padding(.bottom, 16)
            .padding(.leading, 16)
        }
        .frame(width: 154, height: 154)
    }
}

struct TravelNewsEditorListView_Previews: PreviewProvider {
    static var previews: some View {
        TravelNewsEditorListView()
    }
}
