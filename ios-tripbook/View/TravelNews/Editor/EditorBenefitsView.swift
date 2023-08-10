//
//  EditorBenefitsView.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/08/03.
//

import SwiftUI

struct EditorBenefitsView: View {
    let benefits = [
        ["Benefits1", "나는 여행 인플루언서!", "많은 사람들과 내 콘텐츠를 보고 소통해요"],
        ["Benefits2", "오래도록 간직하는 내 기록!", "나만의 여행 기록을 쌓아갈 수 있어요"],
        ["Benefits3", "어디서나 자랑 가능!", "수료증을 발급해드려요"]
    ]
    
    var body: some View {
        VStack {
            Text("한 눈에 보는 에디터 혜택")
                .font(TBFont.heading_2)
                .foregroundColor(.white)
                .padding(.bottom)
            ForEach(0..<benefits.count, id: \.self) { index in
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                    .frame(width: 335, height: 188)
                    .overlay {
                        VStack {
                            Image(benefits[index][0])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 124,height: 98)
                            Text(benefits[index][1])
                                .font(TBFont.caption_1)
                            Text(benefits[index][2])
                                .font(TBFont.title_3)
                        }
                    }
            }
        }
        
    }
}

struct EditorBenefitsView_Previews: PreviewProvider {
    static var previews: some View {
        EditorBenefitsView()
            .background(TBColor.primary.levels[5])
    }
}