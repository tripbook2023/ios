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
public struct TBAppBar<Content> : View where Content : View {
    private var title: String
    private var onClickedBackButton: (() -> Void)?
    @ViewBuilder private var rightItem: () -> Content
    private var iconColor: Color
    
    public init(
        title: String? = nil,
        onClickedBackButton: (() -> Void)? = nil,
        @ViewBuilder rightItem: @escaping () -> Content = { EmptyView() },
        iconColor: Color? = nil
    ) {
        if let title {
            self.title = title
        } else {
            self.title = ""
        }
        self.onClickedBackButton = onClickedBackButton
        self.rightItem = rightItem
        self.iconColor = iconColor ?? TBColor.grayscale._90
    }
    
    public var body: some View {
        ZStack(alignment: .center) {
            HStack {
                if let buttonAction = onClickedBackButton {
                    Button(action: {
                        buttonAction()
                    }) {
                        TBIcon.before[0]
                            .iconSize(size: .medium)
                    }
                    .foregroundColor(iconColor)
                }
                
                Spacer()
                
                rightItem()
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
        TBAppBar(title: "텍스트", onClickedBackButton: {
            
        }, rightItem: {
            Image(systemName: "swift")
        })
        .previewDevice("iPhone 14 Pro")
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
#endif
