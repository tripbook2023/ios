//
//  SwiftUIView.swift
//  
//
//  Created by DDang on 2023/06/15.
//

import SwiftUI

/// Tripbook CheckBox
/// - Author: 김민규
/// - Date: 2023/06/15
public struct TBCheckBox: View {
    @Binding var isChecked: Bool
    
    /// Tripbook CheckBox Initializer
    /// - Parameters:
    ///     - isChecked: Binding CheckBox Checked Variable
    public init(_ isChecked: Binding<Bool>) {
        self._isChecked = isChecked
    }
    
    public var body: some View {
        if self.isChecked {
            Image("Checkbox.enabled").frame(width: 24, height: 24)
        } else {
            Image("Checkbox.disabled").frame(width: 24, height: 24)
        }
    }
}

struct TBCheckBox_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TBCheckBox(.constant(true))
                .previewDevice("iPhone 14 Pro")
                .previewLayout(.sizeThatFits)
                .padding()
            
            TBCheckBox(.constant(false))
                .previewDevice("iPhone 14 Pro")
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
