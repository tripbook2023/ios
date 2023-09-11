//
//  EditorBenefitsView.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/08/03.
//

import SwiftUI

struct Benefit {
    let imageName: String
    let caption: String
    let title: String
}

struct EditorBenefitsView: View {
    let benefits = [
        Benefit(imageName: "Benefits1", caption: "나는 여행 인플루언서!", title: "많은 사람들과 내 콘텐츠를 보고 소통해요"),
        Benefit(imageName: "Benefits2", caption: "오래도록 간직하는 내 기록!", title: "나만의 여행 기록을 쌓아갈 수 있어요"),
        Benefit(imageName: "Benefits3", caption: "어디서나 자랑 가능!", title: "수료증을 발급해드려요")
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
                            Image(benefits[index].imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 124,height: 98)
                            Text(benefits[index].caption)
                                .font(TBFont.caption_1)
                            Text(benefits[index].title)
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
            .background(TBColor.primary._50)
    }
}
