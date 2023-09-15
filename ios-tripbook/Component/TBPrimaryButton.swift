//
//  SwiftUIView.swift
//  
//
//  Created by DDang on 2023/06/14.
//

import SwiftUI

enum TBButtonSize {
    case small, regular, medium, none
    
    var horizontalPadding: CGFloat {
        switch self {
        case .small: return 12
        case .regular: return 16
        case .medium: return 18
        default: return 24
        }
    }
    var verticalPadding: CGFloat {
        switch self {
        case .small: return 6
        case .regular: return 14
        case .medium: return 14
        default: return 16
        }
    }
    var cornerRadius: CGFloat {
        switch self {
        case .small: return 6
        case .regular: return 8
        case .medium: return 12
        default: return 12
        }
    }
    var titleFont: Font {
        switch self {
        case .small: return TBFont.body_4
        case .regular: return TBFont.body_4
        case .medium: return TBFont.body_3
        case .none: return TBFont.body_3
        }
    }
}

enum TBButtonType {
    case filled, outline
    
    var backgroundColor: Color {
        switch self {
        case .filled: return TBColor.primary._50
        case .outline: return .clear
        }
    }
    var pressedBackgroundColor: Color {
        switch self {
        case .filled: return TBColor.primary._60
        case .outline: return TBColor.primary._5
        }
    }
    var disabledBackgroundColor: Color {
        switch self {
        case .filled: return TBColor.grayscale._10
        case .outline: return TBColor.grayscale._1
        }
    }
    
    var strokeColor: Color {
        switch self {
        case .filled: return .clear
        case .outline: return TBColor.primary._50
        }
    }
    var pressedStrokeColor: Color {
        switch self {
        case .filled: return .clear
        case .outline: return TBColor.primary._60
        }
    }
    var disabledStrokeColor: Color {
        switch self {
        case .filled: return .clear
        case .outline: return TBColor.grayscale._20
        }
    }
    
    var fontColor: Color {
        switch self {
        case .filled: return .white
        case .outline: return TBColor.primary._50
        }
    }
    var pressedFontColor: Color {
        switch self {
        case .filled: return .white
        case .outline: return TBColor.primary._60
        }
    }
    var disabledFontColor: Color {
        switch self {
        case .filled: return TBColor.grayscale._60
        case .outline: return TBColor.grayscale._20
        }
    }
}

struct TBButton: View {
    let type: TBButtonType
    let size: TBButtonSize
    let title: String
    let maxWidth: CGFloat?
    let titleTextColor: Color?
    let backgroundColor: Color?
    @Binding var isEnabled: Bool
    let onClickedEvent: (() -> Void)?
    
    init(type: TBButtonType, size: TBButtonSize, title: String, maxWidth: CGFloat? = nil, titleTextColor: Color? = nil, backgroundColor: Color? = nil, isEnabled: Binding<Bool>, onClickedEvent: (() -> Void)? = nil) {
        self.type = type
        self.size = size
        self.title = title
        self.maxWidth = maxWidth
        self.titleTextColor = titleTextColor
        self.backgroundColor = backgroundColor
        self._isEnabled = isEnabled
        self.onClickedEvent = onClickedEvent
    }
    
    var body: some View {
        Button(action: {
            if self.isEnabled {
                self.onClickedEvent?()
            }
        }) {
            Text(self.title)
                .frame(maxWidth: self.maxWidth)
                .padding(.horizontal, self.size.horizontalPadding)
                .padding(.vertical, self.size.verticalPadding)
                .font(self.size.titleFont)
        }
        .cornerRadius(self.size.cornerRadius)
        .buttonStyle(TBButtonStyle(type: self.type, size: self.size, titleTextColor: self.titleTextColor, backgroundColor: self.backgroundColor, isEnabled: self.$isEnabled))
    }
}

struct TBButtonStyle: PrimitiveButtonStyle {
    @State var isPressed = false
    
    let type: TBButtonType
    let size: TBButtonSize
    let titleTextColor: Color?
    var backgroundColor: Color? = nil
    @Binding var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        print(self.type.backgroundColor, self.type.pressedBackgroundColor, self.type.pressedStrokeColor)
        
        let gesture = DragGesture(minimumDistance: 0)
            .onChanged { _ in self.isPressed = true }
            .onEnded { _ in
                self.isPressed = false
                configuration.trigger()
            }
        
        return configuration.label
            .foregroundColor(
                self.titleTextColor != nil ?
                self.titleTextColor! :
                    (self.isEnabled ?
                     (self.isPressed ?
                      self.type.pressedFontColor :
                        self.type.fontColor) :
                        self.type.disabledFontColor)
            )
            .background(
                RoundedRectangle(cornerRadius: self.size.cornerRadius)
                    .inset(by: 0.5)
                    .stroke(
                        self.backgroundColor != nil ?
                        self.backgroundColor! :
                            (self.isEnabled ?
                             (self.isPressed ? self.type.pressedStrokeColor : self.type.strokeColor) :
                                self.type.disabledStrokeColor),
                        lineWidth: 1)
                    .background(
                        self.backgroundColor != nil ?
                        self.backgroundColor! :
                            (self.isEnabled ?
                             (self.isPressed ? self.type.pressedBackgroundColor : self.type.backgroundColor) :
                                self.type.disabledBackgroundColor)
                    )
            ).gesture(gesture)
    }
}

/// Tripbook Primary Button
/// - Author: 김민규
/// - Date: 2023/06/14
struct TBPrimaryButton: View {
    let title: String
    @Binding var isEnabled: Bool
    let onClickedEvent: (() -> Void)?
    
    init(title: String, isEnabled: Binding<Bool>, onClickedEvent: (() -> Void)? = nil) {
        self.title = title
        self._isEnabled = isEnabled
        self.onClickedEvent = onClickedEvent
    }
    
    var body: some View {
        Button(action: {
            if self.isEnabled {
                self.onClickedEvent?()
            }
        }) {
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 52)
                .foregroundColor(self.isEnabled ? TBColor.primary._50 : TBColor.grayscale._10)
                .overlay(
                    Text(self.title)
                        .font(TBFont.body_3)
                )
        }.foregroundColor(self.isEnabled ? .white : TBColor.grayscale._60)
    }
}

struct TBPrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                TBPrimaryButton(title: "label", isEnabled: .constant(true))
                TBPrimaryButton(title: "label",isEnabled: .constant(false))
            }
            
            VStack {
                VStack {
                    HStack {
                        TBButton(type: .filled, size: .small, title: "label", isEnabled: .constant(true))
                        TBButton(type: .outline, size: .small, title: "label", isEnabled: .constant(true))
                    }
                    HStack {
                        TBButton(type: .filled, size: .small, title: "label", isEnabled: .constant(false))
                        TBButton(type: .outline, size: .small, title: "label", isEnabled: .constant(false))
                    }
                }
                
                VStack {
                    HStack {
                        TBButton(type: .filled, size: .regular, title: "label", isEnabled: .constant(true))
                        TBButton(type: .outline, size: .regular, title: "label", isEnabled: .constant(true))
                    }
                    HStack {
                        TBButton(type: .filled, size: .regular, title: "label", isEnabled: .constant(false))
                        TBButton(type: .outline, size: .regular, title: "label", isEnabled: .constant(false))
                    }
                }
                
                VStack {
                    HStack {
                        TBButton(type: .filled, size: .medium, title: "label", isEnabled: .constant(true))
                        TBButton(type: .outline, size: .medium, title: "label", isEnabled: .constant(true))
                    }
                    HStack {
                        TBButton(type: .filled, size: .medium, title: "label", isEnabled: .constant(false))
                        TBButton(type: .outline, size: .medium, title: "label", isEnabled: .constant(false))
                    }
                }
            }
        }
        .previewDevice("iPhone 14 Pro")
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
