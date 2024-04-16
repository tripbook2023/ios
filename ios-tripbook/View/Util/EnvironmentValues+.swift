//
//  EnvironmentValues+.swift
//  ios-tripbook
//
//  Created by 이시원 on 11/18/23.
//

import SwiftUI

struct RootPresentationModeKey: EnvironmentKey {
    static let defaultValue: Binding<RootPresentationMode> = .constant(RootPresentationMode())
}

struct PopupKey: EnvironmentKey {
    static let defaultValue: Binding<TBPopup.ViewType?> = .constant(nil)
}

extension EnvironmentValues {
    var rootPresentationMode: Binding<RootPresentationMode> {
        get { return self[RootPresentationModeKey.self] }
        set { self[RootPresentationModeKey.self] = newValue }
    }
    
    var popupView: Binding<TBPopup.ViewType?> {
        get { return self[PopupKey.self] }
        set { self[PopupKey.self] = newValue }
    }
}

typealias RootPresentationMode = Bool

extension RootPresentationMode {
    
    public mutating func dismiss() {
        self = false
    }
}
