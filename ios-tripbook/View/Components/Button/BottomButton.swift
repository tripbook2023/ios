//
//  BottomButton.swift
//  ios-tripbook
//
//  Created by 박상현 on 2023/05/22.
//

import SwiftUI

/// 회원가입 네비게이션바 델리게이트(프로토콜)
protocol BottomButtonDelegate {
    /// 버튼 클릭 이벤트
    func didTapBottomButton()
    /// 버튼 텍스트 설정
    var buttonTitle: String? { get set }
    /// 버튼 높이 사이즈 설정
    var buttonHeight: CGFloat? { get set }
}

struct BottomButton: View {
    var delegate: BottomButtonDelegate?
    /// 버튼 활성화 여부 설정
    var buttonEnabled: Bool = false
    /// 버튼 활성화시 배경색
    var enabledButtonTint: Color = Color(red: 1, green: 0.306, blue: 0.086)
    /// 버튼 비활성화시 배경색
    var disabledButtonTint: Color = Color(red: 0.882, green: 0.863, blue: 0.859) // #e1dcdb
    /// 버튼 활성화시 글자색
    var enabledButtonTextTint: Color = .white
    /// 버튼 비활성화시 글자색
    var disabledButtonTextTint: Color = Color(red: 0.298, green: 0.271, blue: 0.263) // #4c4543
    
    @State var isActive: Bool?

    var body: some View {
        VStack {
            Button {
                delegate?.didTapBottomButton()
            } label: {
                Text(delegate?.buttonTitle ?? "Button")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(buttonEnabled ? enabledButtonTint : disabledButtonTint)
                    )
                    .foregroundColor(buttonEnabled ? enabledButtonTextTint : disabledButtonTextTint)
            }
            .disabled(buttonEnabled ?? false ? false : true)
        }
    }
}

struct BottomButton_Previews: PreviewProvider {
    static var previews: some View {
        BottomButton(buttonEnabled: true)
    }
}
