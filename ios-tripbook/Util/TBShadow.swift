//
//  TBShadow.swift
//  ios-tripbook
//
//  Created by DDang on 7/11/23.
//

import Foundation
import SwiftUI

struct TBShadow {
    struct ShadowInfo {
        let color: Color
        let radius: CGFloat
        let x: CGFloat
        let y: CGFloat
    }
    
    static let _1: ShadowInfo = .init(color: Color(red: 0.05, green: 0.05, blue: 0.05).opacity(0.2), radius: 2, x: 0, y: 0)
    static let _2: ShadowInfo = .init(color: Color(red: 0.05, green: 0.05, blue: 0.05).opacity(0.2), radius: 5, x: 0, y: 0)
}

extension View {
    func shadow(_ shadowInfo: TBShadow.ShadowInfo) -> some View {
        return self.shadow(color: shadowInfo.color, radius: shadowInfo.radius, x: shadowInfo.x, y: shadowInfo.y)
    }
}
