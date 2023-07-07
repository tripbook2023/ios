//
//  TooltipView.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/13.
//

import SwiftUI

/// Tooltip View
/// - Author: 김민규
/// - Date: 2023/05/15
struct TooltipView: View {
    /// View의 활성화 여부
    @State var isShow = false
    
    /// Tooltip Text
    var text: String
    /// Tooltip이 보여지는 시간(Milliseconds)
    var delayMilliseconds: Int
    /// Tooltip Animation 속도
    var animationSpeed: Double
    
    /// Tooltip View Initializer
    /// - Parameters:
    ///     - text: Tooltip Text
    ///     - delayMilliseconds: Tooltip이 보여지는 시간(Milliseconds)
    ///     - animationSpeed: Tooltip Animation 속도
    init(
        _ text: String,
        delayMilliseconds: Int,
        animationSpeed: Double
    ) {
        self.text = text
        self.delayMilliseconds = delayMilliseconds
        self.animationSpeed = animationSpeed
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(height: 29)
            .foregroundColor(Color(red: 244 / 255, green: 135 / 255, blue: 135 / 255))
            .overlay(
                Text(text)
                    .font(.suit(.bold, size: 16))
                    .foregroundColor(.white)
            )
            .opacity(isShow ? 0.0 : 1.0)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delayMilliseconds)) {
                    withAnimation(Animation.spring().speed(animationSpeed)) {
                        isShow.toggle()
                    }
                }
            }
    }
}

struct TooltipView_Previews: PreviewProvider {
    static var previews: some View {
        TooltipView(
            "오늘 여행기록 수 1,000건",
            delayMilliseconds: 3000,
            animationSpeed: 0.2
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
