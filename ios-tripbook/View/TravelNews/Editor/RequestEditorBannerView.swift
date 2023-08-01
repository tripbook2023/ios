//
//  RequestEditorBannerView.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/07/28.
//

import SwiftUI

struct RequestEditorBannerView: View {
    var body: some View {
        VStack {
            Text("모두에게 내 여행을 자랑하고 싶다면,")
                .font(TBFont.body_3)
                .foregroundColor(TBColor.primary.levels[0])
            Spacer().frame(height: 4)
            HStack {
                Text("여행 에디터")
                    .foregroundColor(TBColor.primary.levels[5])
                + Text("를 신청해보세요!")
                    .foregroundColor(.white)
            }.font(TBFont.heading_1)
            
            Spacer().frame(height: 11)
            Image("EditorBanner")
                .resizable()
                .frame(width: 248, height: 200)
            Spacer().frame(height: 8)
            Text("에디터 신청만 해도 5,000P 지급!")
                .font(TBFont.body_3)
                .foregroundColor(TBColor.primary.levels[1])
        }
    }
}

struct RequestEditorBannerView_Previews: PreviewProvider {
    static var previews: some View {
        RequestEditorBannerView()
    }
}
