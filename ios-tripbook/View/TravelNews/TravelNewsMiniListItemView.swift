//
//  TravelNewsMiniListItemView.swift
//  ios-tripbook
//
//  Created by 이시원 on 11/30/23.
//

import SwiftUI

import Kingfisher

struct TravelNewsMiniListItemView: View {
    private let processor = ResizingImageProcessor(referenceSize: .init(width: 154, height: 154), mode: .aspectFill)
    private let item: TravelNewsModel
    
    init(item: TravelNewsModel) {
        self.item = item
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            KFImage.url(item.thumbnailURL)
                .setProcessor(self.processor)
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .cropping(size: .init(width: 154, height: 154))
                .cornerRadius(12)
            
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(TBColor.grayscale._90.opacity(0.3))
            
            VStack(alignment: .leading, spacing: 4) {
                Spacer()
                
                Text(item.title)
                    .font(TBFont.caption_1)
                    .foregroundColor(.white)
                
                Text(item.createdAt)
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

#if DEBUG
#Preview {
    TravelNewsMiniListItemView(item: TravelNewsModel.dummy)
}
#endif
