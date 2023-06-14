//
//  HomePointBannerView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/14.
//

import SwiftUI

/// 포인트 배너 View
/// - Author: 김민규
/// - Date: 2023/05/15
struct HomePointBannerView: View {
    /// 사용자 이름(닉네임)
    @Binding var name: String
    /// 사용자 보유 포인트
    @Binding var point: Int
    
    var body: some View {
        Rectangle()
            .foregroundColor(Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255))
            .frame(height: 86)
            .overlay(
                HStack {
                    Image("SampleProfileImage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 49, height: 49)
                        .clipped()
                    
                    VStack(alignment: .leading) {
                        Text("\(self.name)님의 보유 포인트")
                            .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 10))
                            .foregroundColor(.black)
                        Text("\(self.point) 포인트")
                            .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 15))
                            .foregroundColor(.black)
                        Button(action: {}) {
                            Text("포인트 더 모으기 >")
                                .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 10))
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            )
    }
}

struct HomePointBannerView_Previews: PreviewProvider {
    static var previews: some View {
        HomePointBannerView(name: .constant("홍길동"), point: .constant(1000))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
