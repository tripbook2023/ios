//
//  MainBannerView.swift
//  ios-tripbook
//
//  Created by 이시원 on 12/14/23.
//

import SwiftUI

struct MainBannerView: View {
    @Environment(\.popupView) private var popupView
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                Text("트립북에 대해\n자세히 알아보세요!")
                    .font(TBFont.title_2)
                    .foregroundStyle(TBColor.grayscale._90)
                
                TBButton(
                    type: .filled,
                    size: .small,
                    title: "자세히 보기",
                    isEnabled: .constant(true)
                ) {
                    popupView.wrappedValue = .ruide(
                        title: "트립북 노션 페이지로 이동하시겠습니까?",
                        confirmButtonText: "이동",
                        dismissButtonText: "취소",
                        didTapConfirmButton: {
                            UIApplication.shared.open(
                                .init(string: "https://midnight-chips-141.notion.site/54d5642a439741eca80359e04b920876")!
                            )
                        }
                    )
                }
            }
            VStack {
                Spacer()
                Image("MainBanner")
                    .frame(width: 214, height: 140)
            }
            
        }
        .frame(height: 150)
    }
}

#Preview {
    MainBannerView()
        
}
