//
//  SwiftUIView.swift
//  
//
//  Created by DDang on 2023/06/14.
//

import SwiftUI

/// Tripbook AppBar
/// - Author: 김민규
/// - Date: 2023/06/14
public struct TBAppBar: View {
    var title: String
    var onClickedBackButton: () -> Void
    
    public init(title: String? = nil, onClickedBackButton: @escaping () -> Void) {
        if let title {
            self.title = title
        } else {
            self.title = ""
        }
        self.onClickedBackButton = onClickedBackButton
    }
    
    public var body: some View {
        ZStack(alignment: .center) {
            HStack {
                Button(action: {
                    self.onClickedBackButton()
                }) {
                    TBIcon.before[0]
                        .iconSize(size: .medium)
                }.foregroundColor(TBColor.grayscale._90)
                Spacer()
            }
            
            Text(self.title)
                .font(TBFont.body_3)
                .foregroundColor(TBColor.grayscale._80)
        }.frame(height: 48)
    }
}

#if DEBUG
struct TBAppBar_Previews: PreviewProvider {
    static var previews: some View {
        TBAppBar(title: "텍스트") {
            
        }
        .previewDevice("iPhone 14 Pro")
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
#endif
