//
//  ToggleButton.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/14.
//

import SwiftUI

/// Tripbook Image Toggle Button
/// - Author: 김민규
/// - Date: 2023/05/15
struct ToggleButton: View {
    
    /// Button의 독립적인 설정 정의
    struct configure {
        /// Button의 이미지
        let image: Image
        /// Button의 색상
        let color: Color
    }
    
    /// 토글 여부
    @Binding var isToggled: Bool
    /// 토글 여부에 따른 Button의 설정 정의
    let configureByState: [Bool:configure]
    
    /// Button 텍스트
    var text: String? = nil
    /// Button 토글 Count
    @Binding var count: Int
    
    /// Button 토글 카운팅 여부
    var isCounting: Bool = false
    /// 추가적인 Button Click Event
    var onClickedEvent: () -> Void
    
    /// 토글에 따른 상태 변화가 없는 Text Toggle Button
    /// - Parameters:
    ///     - isToggled: 토글 여부
    ///     - image: Button의 이미지
    ///     - color: Button의 색상
    ///     - text: Button 텍스트
    ///     - onClickedEvent: 추가적인 Button Click Event
    init(
        isToggled: Binding<Bool>,
        image: Image,
        color: Color,
        text: String? = nil,
        _ onClickedEvent: @escaping () -> Void
    ) {
        self._isToggled = isToggled
        self.configureByState = [
            true: .init(image: image, color: color),
            false: .init(image: image, color: color)
        ]
        if let text = text {
            self.text = text
        }
        self._count = .constant(-1)
        self.onClickedEvent = onClickedEvent
    }
    
    /// 토글에 따른 상태 변화가 없는 Text Toggle Button
    /// - Parameters:
    ///     - isToggled: 토글 여부
    ///     - image: Button의 이미지
    ///     - color: Button의 색상
    ///     - isCounting: Button 토글 카운팅 여부
    ///     - count: Button 토글 Count
    ///     - onClickedEvent: 추가적인 Button Click Event
    init(
        isToggled: Binding<Bool>,
        image: Image,
        color: Color,
        isCounting: Bool,
        count: Binding<Int>,
        _ onClickedEvent: @escaping () -> Void
    ) {
        self._isToggled = isToggled
        self.configureByState = [
            true: .init(image: image, color: color),
            false: .init(image: image, color: color)
        ]
        self.isCounting = isCounting
        self._count = count
        self.onClickedEvent = onClickedEvent
    }
    
    /// 토글에 따른 상태 변화가 없는 Text Toggle Button
    /// - Parameters:
    ///     - isToggled: 토글 여부
    ///     - configureByState: 토글 여부에 따른 Button의 설정 정의
    ///     - text: Button 텍스트
    ///     - onClickedEvent: 추가적인 Button Click Event
    init(
        isToggled: Binding<Bool>,
        configureByState: [Bool:configure],
        text: String? = nil,
        _ onClickedEvent: @escaping () -> Void
    ) {
        self._isToggled = isToggled
        self.configureByState = configureByState
        if let text = text {
            self.text = text
        }
        self._count = .constant(-1)
        self.onClickedEvent = onClickedEvent
    }
    
    /// 토글에 따른 상태 변화가 없는 Text Toggle Button
    /// - Parameters:
    ///     - isToggled: 토글 여부
    ///     - configureByState: 토글 여부에 따른 Button의 설정 정의
    ///     - isCounting: Button 토글 카운팅 여부
    ///     - count: Button 토글 Count
    ///     - onClickedEvent: 추가적인 Button Click Event
    init(
        isToggled: Binding<Bool>,
        configureByState: [Bool:configure],
        isCounting: Bool,
        count: Binding<Int>,
        _ completion: @escaping () -> Void) {
        self._isToggled = isToggled
        self.configureByState = configureByState
        self.isCounting = isCounting
        self._count = count
        self.onClickedEvent = completion
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Button(action: {
                if isCounting {
                    if self.isToggled {
                        self.count -= 1
                    } else {
                        self.count += 1
                    }
                }
                
                self.isToggled.toggle()
                
                self.onClickedEvent()
            }) {
                self.configureByState[self.isToggled]!.image
            }.foregroundColor(self.configureByState[self.isToggled]!.color)
            
            if let text = self.text {
                Text(text)
                    .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 14))
            } else if count > 0 {
                Text("\(count)")
                    .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 14))
            }
        }
    }
}

struct ToggleButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ToggleButton(
                isToggled: .constant(false),
                image: Image(systemName: "checkmark.square"),
                color: .primary,
                text: "(필수) 서비스 이용약관 동의"
            ) {}
            .previewLayout(.sizeThatFits)
            .padding()
            
            ToggleButton(
                isToggled: .constant(false),
                image: Image(systemName: "heart"),
                color: .primary,
                isCounting: false,
                count: .constant(1)
            ) {}
            .previewLayout(.sizeThatFits)
            .padding()
            
            ToggleButton(
                isToggled: .constant(false),
                configureByState: [
                    true: .init(image: Image(systemName: "checkmark.square.fill"), color: .primary),
                    false: .init(image: Image(systemName: "checkmark.square"), color: .primary)
                ],
                text: "(필수) 서비스 이용약관 동의"
            ) {}
            .previewLayout(.sizeThatFits)
            .padding()

            ToggleButton(
                isToggled: .constant(true),
                configureByState: [
                    true: .init(image: Image(systemName: "heart.fill"), color: .pink),
                    false: .init(image: Image(systemName: "heart"), color: .primary)
                ],
                isCounting: true,
                count: .constant(2)
            ) {}
            .previewLayout(.sizeThatFits)
            .padding()
        }
    }
}
