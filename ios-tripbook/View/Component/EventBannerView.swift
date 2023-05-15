//
//  EventBannerView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/26.
//

import SwiftUI

/// 이벤트 배너 View
/// - Author: 김민규
/// - Date: 2023/05/15
struct EventBannerView: View {
    
    /// 이벤트 배너 Text
    var text: String
    /// 이벤트 배너 이미지(로고)
    var image: UIImage?
    /// 이벤트 배너 Click Event 정의
    var onClickEvent: () -> Void
    
    /// 이벤트 배너 View Initializer
    /// - Parameters:
    ///     - text: 이벤트 배너 Text
    ///     - image: 이벤트 배너 이미지(로고)
    ///     - onClickEvent: 이벤트 배너 Click Event 정의
    init(
        text: String,
        image: UIImage? = nil,
        onClickEvent: @escaping () -> Void
    ) {
        self.text = text
        self.image = image
        self.onClickEvent = onClickEvent
    }
    
    var body: some View {
        Button(action: self.onClickEvent) {
            Rectangle()
                .foregroundColor(Color(red: 255 / 255, green: 240 / 255, blue: 240 / 255))
                .overlay(
                    HStack(spacing: 10) {
                        Text(self.text)
                            .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 19))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.black)
                        
                        if let image = self.image {
                            Circle()
                                .frame(width: 73, height: 73)
                                .foregroundColor(.white)
                                .overlay(
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .padding(.all, 19)
                                )
                        }
                    }.padding()
                )
        }
    }
}

struct EventBannerView_Previews: PreviewProvider {
    static var previews: some View {
        EventBannerView(text: "여행기록하고 굿즈 받자!") { }
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
