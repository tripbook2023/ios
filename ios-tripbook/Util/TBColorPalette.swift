//
//  File.swift
//  
//
//  Created by DDang on 2023/05/24.
//

import Foundation
import SwiftUI

public extension Color {
    /// RGB
    /// - author: 김민규
    /// - Date: 2023/05/24
    struct RGB {
        var red: Double
        var green: Double
        var blue: Double
    }
    
    /// Color Initializer by Hex Code
    /// - Parameters:
    ///     - hex: color hex code (Ex. #000000)
    /// - author: 김민규
    /// - Date: 2023/05/24
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
    
    /// Color Initializer by RGB
    /// - Parameters:
    ///     - rgb: RGB Numbers
    /// - author: 김민규
    /// - Date: 2023/05/24
    init(rgb: RGB) {
        self.init(red: rgb.red / 255, green: rgb.green / 255, blue: rgb.blue / 255)
    }
}

/// Tripbook 고유 Color 명세
/// - author: 김민규
/// - Date: 2023/05/24
public struct TBColor {
    /// Tripbook Color Set
    /// - author: 김민규
    /// - Date: 2023/05/24
    public struct TBColorLevel {
        /// Color Level (a.k.a. 명도)
        public var levels: [Color]
        /// Main Color
        public var main: Color
        
        /// Color Initializer by RGB
        /// - Parameters:
        ///     - mainColor: Main Color (Optional)
        ///     - _0: Color Level 0 (Optional)
        ///     - _10: Color Level 10
        ///     - _20: Color Level 20
        ///     - _30: Color Level 30
        ///     - _40: Color Level 40
        ///     - _50: Color Level 50
        ///     - _60: Color Level 60
        ///     - _70: Color Level 70
        ///     - _80: Color Level 80
        ///     - _90: Color Level 90
        ///     - _100: Color Level 100 (Optional)
        /// - author: 김민규
        /// - Date: 2023/05/24
        init(
            mainColor: Color? = nil,
            _0: Color? = nil,
            _10: Color,
            _20: Color,
            _30: Color,
            _40: Color,
            _50: Color,
            _60: Color,
            _70: Color,
            _80: Color,
            _90: Color,
            _100: Color? = nil
        ) {
            self.levels = [_10, _20, _30, _40, _50, _60, _70, _80, _90]
            
            // `_0` 파라미터가 있다면
            if let _0 = _0 {
                self.levels.insert(_0, at: 0)
            }
            // `_100` 파라미터가 있다면
            if let _100 = _100 {
                self.levels.append(_100)
            }
            
            // `mainColor` 파라미터가 있다면
            if let mainColor = mainColor {
                self.main = mainColor
            } else {
                self.main = self.levels[self.levels.count / 2]
            }
        }
        
        /// 모든 Level의 Color를 반환
        /// - author: 김민규
        /// - Date: 2023/05/24
        func all() -> [Color] {
            return self.levels
        }
    }
    
    /// Tripbook Point Colors
    /// - author: 김민규
    /// - Date: 2023/05/24
    public struct TBPointColorPalette {
        var green: [Color]
        var navy: [Color]
    }
    
    /// Tripbook State Colors
    /// - author: 김민규
    /// - Date: 2023/05/24
    public struct TBColorState {
        /// 경고
        public var warning: Color
    }
    
    /// Tripbook Primary Colors
    static public let primary: TBColorLevel = .init(
        _10: Color(rgb: Color.RGB(red: 255, green: 214, blue: 173)),
        _20: Color(rgb: Color.RGB(red: 255, green: 194, blue: 148)),
        _30: Color(rgb: Color.RGB(red: 255, green: 167, blue: 112)),
        _40: Color(rgb: Color.RGB(red: 255, green: 126, blue: 61)),
        _50: Color(rgb: Color.RGB(red: 255, green: 78, blue: 22)),
        _60: Color(rgb: Color.RGB(red: 229, green: 46, blue: 0)),
        _70: Color(rgb: Color.RGB(red: 199, green: 33, blue: 0)),
        _80: Color(rgb: Color.RGB(red: 173, green: 17, blue: 0)),
        _90: Color(rgb: Color.RGB(red: 143, green: 5, blue: 0))
    )
    
    /// Tripbook Secondary Colors
    static public let secondary: TBColorLevel = .init(
        _10: Color(rgb: Color.RGB(red: 255, green: 244, blue: 199)),
        _20: Color(rgb: Color.RGB(red: 255, green: 239, blue: 173)),
        _30: Color(rgb: Color.RGB(red: 255, green: 233, blue: 143)),
        _40: Color(rgb: Color.RGB(red: 255, green: 223, blue: 97)),
        _50: Color(rgb: Color.RGB(red: 255, green: 213, blue: 47)),
        _60: Color(rgb: Color.RGB(red: 255, green: 205, blue: 5)),
        _70: Color(rgb: Color.RGB(red: 224, green: 180, blue: 0)),
        _80: Color(rgb: Color.RGB(red: 189, green: 151, blue: 0)),
        _90: Color(rgb: Color.RGB(red: 148, green: 118, blue: 0))
    )
    
    /// Tripbook Point Colors
    static public let point: TBPointColorPalette = .init(
        green: [
            Color(rgb: Color.RGB(red: 123, green: 243, blue: 151)),
            Color(rgb: Color.RGB(red: 103, green: 203, blue: 148)),
            Color(rgb: Color.RGB(red: 0, green: 87, blue: 58))
        ],
        navy: [
            Color(rgb: Color.RGB(red: 9, green: 31, blue: 51))
        ]
    )
    
    /// Tripbook Grayscale Colors
    static public let grayscale: TBColorLevel = .init(
        _0: Color(rgb: Color.RGB(red: 250, green: 249, blue: 249)),
        _10: Color(rgb: Color.RGB(red: 239, green: 236, blue: 236)),
        _20: Color(rgb: Color.RGB(red: 225, green: 220, blue: 219)),
        _30: Color(rgb: Color.RGB(red: 199, green: 191, blue: 189)),
        _40: Color(rgb: Color.RGB(red: 159, green: 150, blue: 147)),
        _50: Color(rgb: Color.RGB(red: 127, green: 116, blue: 113)),
        _60: Color(rgb: Color.RGB(red: 97, green: 89, blue: 86)),
        _70: Color(rgb: Color.RGB(red: 76, green: 69, blue: 67)),
        _80: Color(rgb: Color.RGB(red: 52, green: 47, blue: 45)),
        _90: Color(rgb: Color.RGB(red: 28, green: 24, blue: 23)),
        _100: Color(rgb: Color.RGB(red: 14, green: 12, blue: 12))
    )
    
    /// Tripbook State Colors
    static public let state: TBColorState = .init(
        warning: Color(rgb: Color.RGB(red: 221, green: 54, blue: 44))
    )
}

#if DEBUG
struct TBColorPalette_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(TBColor.grayscale.all(), id: \.self) { level in
                    level
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                }
            }
            .padding()
            .previewDisplayName("Grayscale")
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Main").font(.title)
                TBColor.primary.main
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                Divider().padding(.vertical)
                ForEach(TBColor.primary.all(), id: \.self) { level in
                    level
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                }
            }
            .padding()
            .previewDisplayName("Primary")
            
            VStack(alignment: .leading, spacing: 0) {
                ForEach(TBColor.secondary.all(), id: \.self) { level in
                    level
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                }
            }
            .padding()
            .previewDisplayName("Secondary")
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Green").font(.title)
                ForEach(TBColor.point.green, id: \.self) { level in
                    level
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                }
                Divider().padding(.vertical)
                Text("Navy").font(.title)
                ForEach(TBColor.point.navy, id: \.self) { level in
                    level
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                }
            }
            .padding()
            .previewDisplayName("Point")
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Warning").font(.title)
                TBColor.state.warning
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
            }
            .padding()
            .previewDisplayName("State")
        }.previewLayout(.sizeThatFits)
    }
}
#endif
