//
//  HomeTitleView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/04/26.
//

import SwiftUI

/**
 View: 홈 화면- 제목
 */
struct HomeTitleView: View {
    var loggedInTitle: Text
    
    init(userName: String, countOfReports: Int) {
        self.loggedInTitle = {
            let prefixString = Text("\(userName)님은 ")
            let numberOfReportsString = Text("\(countOfReports)편")
                .foregroundColor(Color(red: 255 / 255, green: 78 / 255, blue: 0.0))
            let suffixString = Text("의 여행기록 작성완료!")
            
            return (prefixString + numberOfReportsString + suffixString)
                .font(.custom(TBFontType.NotoSansKR.bold.rawValue, size: 23))
        }()
    }
    
    var body: some View {
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
    }
}

struct HomeTitleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeTitleView(userName: "홍길동", countOfReports: 1)
                .padding()
                .previewDisplayName("Auth")
        }.previewLayout(.sizeThatFits)
    }
}
