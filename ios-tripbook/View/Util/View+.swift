//
//  View+.swift
//  ios-tripbook
//
//  Created by 이시원 on 4/15/24.
//

import SwiftUI
import UIKit

extension View {
    func showAlert(content: Binding<TBPopup.ViewType?>) -> some View {
        self.overlay {
            TBPopup(type: content)
            .ignoresSafeArea()
            .opacity(content.wrappedValue != nil ? 1 : 0)
        }
    }
}
