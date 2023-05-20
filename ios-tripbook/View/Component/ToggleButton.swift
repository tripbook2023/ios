//
//  ToggleButton.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/14.
//

import SwiftUI

/// Based Toggle Button Properties
/// - Author: 김민규
/// - Date: 2023/05/20
protocol ToggleButtonProtocol {
    /// Toggle Image
    var image: Image { get }
    /// Toggle Image Color
    var imageColor: Color { get }
    /// Toggle Image Size
    var imageSize: CGSize { get }
    /// Text Label Color
    var labelColor: Color { get }
    
    /// Toggle 여부
    var isToggled: Binding<Bool> { get }
    /// 추가 Click 이벤트
    var onClickedEvent: () -> Void { get }
}

/// Based Toggle Button Action
/// - Author: 김민규
/// - Date: 2023/05/20
extension ToggleButtonProtocol {
    func toggle() {
        self.isToggled.wrappedValue.toggle()
    }
}

/// Text Label Toggle Button
/// - Author: 김민규
/// - Date: 2023/05/20
struct TextToggleButton: View, ToggleButtonProtocol {
    var image: Image
    var imageColor: Color
    var imageSize: CGSize = .init(width: 24, height: 24)
    var labelColor: Color = .primary
    
    var isToggled: Binding<Bool>
    /// Text String
    var text: String
    
    var onClickedEvent: () -> Void
    
    var body: some View {
        HStack(alignment: .top) {
            Button(action: {
                self.toggle()

                self.onClickedEvent()
            }) {
                self.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageSize.width, height: imageSize.height)
            }.foregroundColor(self.imageColor)
            
            Text(self.text)
                .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 14))
                .foregroundColor(self.labelColor)
        }
    }
}

/// Counting Text Label Toggle Button
/// - Author: 김민규
/// - Date: 2023/05/20
struct CountingToggleButton: View, ToggleButtonProtocol {
    var image: Image
    var imageColor: Color
    var imageSize: CGSize = .init(width: 24, height: 24)
    var labelColor: Color = .primary
    
    var isToggled: Binding<Bool>
    /// Current Count
    @Binding var count: Int
    
    var onClickedEvent: () -> Void
    
    var body: some View {
        HStack(alignment: .top) {
            Button(action: {
                self.toggle()

                counting()

                self.onClickedEvent()
            }) {
                self.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageSize.width, height: imageSize.height)
            }.foregroundColor(self.imageColor)
            
            countView
        }
    }
    
    /// Toggle에 의한 Count 계산
    func counting() {
        self.count += self.isToggled.wrappedValue ? 1 : -1
    }
    
    /// Count Text Label View
    var countView: some View {
        Text(self.count > 0 ? String(self.count) : "")
            .font(.custom(TBFontType.NotoSansKR.regular.rawValue, size: 14))
            .foregroundColor(self.labelColor)
    }
}

/// Based Toggle Button
/// - Author: 김민규
/// - Date: 2023/05/20
struct ToggleButton: View, ToggleButtonProtocol {
    var image: Image
    var imageColor: Color
    var imageSize: CGSize = .init(width: 24, height: 24)
    var labelColor: Color = .primary
    
    var isToggled: Binding<Bool>
    
    var onClickedEvent: () -> Void
    
    var body: some View {
        Button(action: {
            self.toggle()
            
            self.onClickedEvent()
        }) {
            self.image
                .resizable()
                .scaledToFit()
                .frame(width: imageSize.width, height: imageSize.height)
        }.foregroundColor(self.imageColor)
    }
}

struct ToggleButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextToggleButton(
                image: Image(systemName: "checkmark.square"),
                imageColor: .primary,
                labelColor: .primary,
                isToggled: .constant(false),
                text: "(필수) 서비스 이용약관 동의"
            ) {
                
            }
            .previewDisplayName("Text ToggleButton")
            .previewLayout(.sizeThatFits)
            .padding()
            
            CountingToggleButton(
                image: Image(systemName: "heart"),
                imageColor: .primary,
                labelColor: .primary,
                isToggled: .constant(false),
                count: .constant(1)
            ) {
                
            }
            .previewDisplayName("Counting ToggleButton")
            .previewLayout(.sizeThatFits)
            .padding()
        }
    }
}
