//
//  EventBannerView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/26.
//

import SwiftUI

struct EventBannerView: View {
    var body: some View {
        HStack(spacing: 10) {
            Image("SampleProfileImage")
                .resizable()
                .scaledToFill()
                .frame(width: 69, height: 69)
                .clipped()
            
            Text("2023.04.01-04.03\n3일 동안 여행기록 남기면\n포인트를 2배 적립해드려요!")
                .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 17))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.black)
        }
        .padding()
        .background(Color(red: 217 / 255, green: 217 / 255, blue: 217 / 255))
        .cornerRadius(20.0)
        .frame(maxWidth: .infinity)
    }
}

struct EventBannerView_Previews: PreviewProvider {
    static var previews: some View {
        EventBannerView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
