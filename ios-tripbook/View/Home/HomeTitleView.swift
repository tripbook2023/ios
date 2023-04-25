//
//  HomeTitleView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/26.
//

import SwiftUI

struct HomeTitleView: View {
    @State var isLoggedIn: Bool
    
    let loggedInTitle: Text
    
    init(isLoggedIn: Bool) {
        self.isLoggedIn = isLoggedIn
        self.loggedInTitle = {
            let prefixString = Text("홍길동님은 ")
                .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 23))
            let numberOfReportsString = Text("1편")
                .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 23))
                .foregroundColor(Color(red: 255 / 255, green: 78 / 255, blue: 0.0))
            let suffixString = Text("의 여행기록 작성완료!")
                .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 23))
            
            return prefixString + numberOfReportsString + suffixString
        }()
    }
    
    var body: some View {
        if isLoggedIn {
            VStack(alignment: .leading, spacing: 0) {
                loggedInTitle
                HStack(alignment: .bottom) {
                    Text("새로운 여행추억을 기록하고\n지금 바로 10 포인트를 적립해보세요!")
                        .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 20))
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Image(systemName: "chevron.forward")
                            .resizable()
                            .fixedSize()
                            .frame(width: 25, height: 25)
                    }.foregroundColor(.black)
                }
            }
        } else {
            Text("트래블리님, 지금 여행기록 하고\n스타벅스 벚꽃라떼 한 잔 어떠세요?")
                .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 23))
        }
    }
}

struct HomeTitleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeTitleView(isLoggedIn: true)
                .padding()
                .previewDisplayName("Auth")
            HomeTitleView(isLoggedIn: false)
                .padding()
                .previewDisplayName("Not-Auth")
        }.previewLayout(.sizeThatFits)
    }
}
