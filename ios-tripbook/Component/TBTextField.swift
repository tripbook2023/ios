//
//  SwiftUIView.swift
//  
//
//  Created by DDang on 2023/06/14.
//

import SwiftUI

/// Tripbook Normal/Validation TextField
/// - Author: 김민규
/// - Date: 2023/06/14
@available(iOS 15.0, *)
@available(macOS 12.0, *)
public struct TBTextField: View {
    
    /// TextField Placeholder
    let title: String
    /// TextField Input Text
    @Binding var text: String
    /// TextField Focus 여부
    @FocusState var isFocused: Bool
    /// TextField Input Text Validation 통과 여부
    @Binding var isValid: Bool?
    /// TextField Input Text Validation 통과 실패시 문구
    @Binding var warningMessage: String?
    /// TextField Submit Event
    var onSubmitEvent: () -> Void
    
    public init(title: String, text: Binding<String>, isValid: Binding<Bool?> = .constant(nil), warningMessage: Binding<String?> = .constant(nil), onSubmitEvent: @escaping () -> Void) {
        self.title = title
        self._text = text
        self._isValid = isValid
        self._warningMessage = warningMessage
        self.onSubmitEvent = onSubmitEvent
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            HStack {
                TextField(self.title, text: self.$text)
                    .padding(.vertical, 14)
                    .background(Color.clear)
                    .font(TBFont.body_4)
                    .foregroundColor(!self.text.isEmpty || self.isFocused ? TBColor.grayscale.levels[10] : TBColor.grayscale.levels[3])
                    .autocorrectionDisabled(true)
                    .onSubmit {
                        self.onSubmitEvent()
                    }
                if !self.text.isEmpty {
                    if self.isValid != nil && self.isValid! {
                        TBIcon.check
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(TBColor.primary.main)
                    } else {
                        Button(action: {
                            self.text = ""
                        }) {
                            ZStack {
                                Circle()
                                    .foregroundColor(TBColor.grayscale.levels[2])
                                    
                                TBIcon.cancel.iconSize(size: .tiny)
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(width: 18, height: 18)
                        
                    }
                }
            }
            Divider()
                .frame(height: 1)
                .background((!self.text.isEmpty && (self.isValid != nil && !self.isValid!)) ?
                            TBColor.state.warning :
                                (!self.text.isEmpty || self.isFocused) ?
                            TBColor.grayscale.levels[9] :
                                TBColor.grayscale.levels[2]
                )
            
            if self.warningMessage != nil && !self.text.isEmpty && (self.isValid != nil && !self.isValid!) {
                HStack(spacing: 4) {
                    TBIcon.state.error
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                    
                    Text(self.warningMessage!)
                        .font(TBFont.caption_1)
                        .foregroundColor(TBColor.state.warning)
                    
                    Spacer()
                }.padding(.top, 12)
            }
        }
    }
}

#if DEBUG
struct TBTextField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TBTextField(
                title: "label",
                text: .constant(""),
                isValid: .constant(nil),
                warningMessage: .constant(nil)
            ) {
                
            }
            
            TBTextField(
                title: "label",
                text: .constant("l"),
                isValid: .constant(nil),
                warningMessage: .constant(nil)
            ) {
                
            }
            
            TBTextField(
                title: "label",
                text: .constant("label"),
                isValid: .constant(true),
                warningMessage: .constant("warning message")
            ) {
                
            }
            
            TBTextField(
                title: "label",
                text: .constant("label"),
                isValid: .constant(false),
                warningMessage: .constant("warning message")
            ) {
                
            }
        }
        .previewDevice("iPhone 14 Pro")
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
#endif
