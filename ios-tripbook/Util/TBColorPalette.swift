//
//  File.swift
//
//
//  Created by DDang on 2023/05/24.
//

import Foundation
import SwiftUI

extension Color {
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
struct TBColor {
    /// Tripbook Color Set
    /// - author: 김민규
    /// - Date: 2023/05/24
    struct TBColorLevel {
        /// Color Level (a.k.a. 명도)
        let _1: Color
        let _5: Color
        let _10: Color
        let _20: Color
        let _30: Color
        let _40: Color
        let _50: Color
        let _60: Color
        let _70: Color
        let _80: Color
        let _90: Color
        
        /// Color Initializer by RGB
        /// - Parameters:
        ///     - _1: Color Level 1
        ///     - _5: Color Level 5
        ///     - _10: Color Level 10
        ///     - _20: Color Level 20
        ///     - _30: Color Level 30
        ///     - _40: Color Level 40
        ///     - _50: Color Level 50
        ///     - _60: Color Level 60
        ///     - _70: Color Level 70
        ///     - _80: Color Level 80
        ///     - _90: Color Level 90
        /// - author: 김민규
        /// - Date: 2023/05/24
        init(
            _1: Color,
            _5: Color,
            _10: Color,
            _20: Color,
            _30: Color,
            _40: Color,
            _50: Color,
            _60: Color,
            _70: Color,
            _80: Color,
            _90: Color
        ) {
            self._1 = _1
            self._5 = _5
            self._10 = _10
            self._20 = _20
            self._30 = _30
            self._40 = _40
            self._50 = _50
            self._60 = _60
            self._70 = _70
            self._80 = _80
            self._90 = _90
        }
        
        /// 모든 Level의 Color를 반환
        /// - author: 김민규
        /// - Date: 2023/05/24
        func all() -> [Color] {
            return [
                self._1,
                self._5,
                self._10,
                self._20,
                self._30,
                self._40,
                self._50,
                self._60,
                self._70,
                self._80,
                self._90
            ]
        }
    }
    
    /// Tripbook Point Colors
    /// - author: 김민규
    /// - Date: 2023/05/24
    struct TBPointColorPalette {
        let green: [Color]
        let navy: [Color]
    }
    
    /// Tripbook State Colors
    /// - author: 김민규
    /// - Date: 2023/05/24
    struct TBColorState {
        /// 경고
        let warning: Color
        let success: Color
    }
    
    /// Tripbook Primary Colors
    static let primary: TBColorLevel = .init(
        _1: .init(rgb: .init(red: 255, green: 249, blue: 242)),
        _5: .init(rgb: .init(red: 255, green: 236, blue: 217)),
        _10: .init(rgb: .init(red: 255, green: 214, blue: 173)),
        _20: .init(rgb: .init(red: 255, green: 194, blue: 148)),
        _30: .init(rgb: .init(red: 255, green: 167, blue: 112)),
        _40: .init(rgb: .init(red: 255, green: 126, blue: 61)),
        _50: .init(rgb: .init(red: 255, green: 78, blue: 22)),
        _60: .init(rgb: .init(red: 229, green: 46, blue: 0)),
        _70: .init(rgb: .init(red: 199, green: 33, blue: 0)),
        _80: .init(rgb: .init(red: 173, green: 17, blue: 0)),
        _90: .init(rgb: .init(red: 143, green: 5, blue: 0))
    )
    
    /// Tripbook Secondary Colors
    static let secondary: TBColorLevel = .init(
        _1: .init(rgb: .init(red: 255, green: 252, blue: 240)),
        _5: .init(rgb: .init(red: 255, green: 249, blue: 225)),
        _10: .init(rgb: .init(red: 255, green: 244, blue: 199)),
        _20: .init(rgb: .init(red: 255, green: 239, blue: 173)),
        _30: .init(rgb: .init(red: 255, green: 233, blue: 143)),
        _40: .init(rgb: .init(red: 255, green: 223, blue: 97)),
        _50: .init(rgb: .init(red: 255, green: 213, blue: 47)),
        _60: .init(rgb: .init(red: 255, green: 205, blue: 5)),
        _70: .init(rgb: .init(red: 224, green: 180, blue: 0)),
        _80: .init(rgb: .init(red: 189, green: 151, blue: 0)),
        _90: .init(rgb: .init(red: 148, green: 118, blue: 0))
    )
    
    /// Tripbook Point Colors
    static let point: TBPointColorPalette = .init(
        green: [
            .init(rgb: .init(red: 123, green: 243, blue: 151)),
            .init(rgb: .init(red: 103, green: 203, blue: 148)),
            .init(rgb: .init(red: 0, green: 87, blue: 58))
        ],
        navy: [
            .init(rgb: .init(red: 9, green: 31, blue: 51))
        ]
    )
    
    /// Tripbook Grayscale Colors
    static let grayscale: TBColorLevel = .init(
        _1: .init(rgb: .init(red: 250, green: 249, blue: 249)),
        _5: .init(rgb: .init(red: 239, green: 236, blue: 236)),
        _10: .init(rgb: .init(red: 225, green: 220, blue: 219)),
        _20: .init(rgb: .init(red: 199, green: 191, blue: 189)),
        _30: .init(rgb: .init(red: 159, green: 150, blue: 147)),
        _40: .init(rgb: .init(red: 127, green: 116, blue: 113)),
        _50: .init(rgb: .init(red: 97, green: 89, blue: 86)),
        _60: .init(rgb: .init(red: 76, green: 69, blue: 67)),
        _70: .init(rgb: .init(red: 52, green: 47, blue: 45)),
        _80: .init(rgb: .init(red: 28, green: 24, blue: 23)),
        _90: .init(rgb: .init(red: 14, green: 12, blue: 12))
    )
    
    /// Tripbook State Colors
    static  let state: TBColorState = .init(
        warning: .init(rgb: .init(red: 221, green: 54, blue: 44)),
        success: .init(rgb: .init(red: 44, green: 221, blue: 189))
    )
}

#if DEBUG
struct TBColorPalette_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(TBColor.grayscale.all(), id: \.self) { level in
                        level
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                    }
                }.padding(.vertical)
            }
            .ignoresSafeArea()
            .previewDisplayName("Grayscale")
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(TBColor.primary.all(), id: \.self) { level in
                        level
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                    }
                }.padding(.vertical)
            }
            .ignoresSafeArea()
            .previewDisplayName("Primary")
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(TBColor.secondary.all(), id: \.self) { level in
                        level
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                    }
                }.padding(.vertical)
            }
            .ignoresSafeArea()
            .previewDisplayName("Secondary")
            
            ScrollView {
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
                }.padding(.vertical)
            }
            .previewDisplayName("Point")
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Warning").font(.title)
                    TBColor.state.warning
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                    Text("Success").font(.title)
                    TBColor.state.success
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                }.padding(.vertical)
            }
            .previewDisplayName("State")
        }.previewLayout(.sizeThatFits)
    }
}
#endif
