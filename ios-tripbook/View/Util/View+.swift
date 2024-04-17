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
    
    func onWillDisappear(_ perform: @escaping () -> Void) -> some View {
        background(WillDisappearHandler(onWillDisappear: perform))
    }
    
    func onWillAppear(_ perform: @escaping () -> Void) -> some View {
        background(WillAppearHandler(onWillAppear: perform))
    }
}

private struct WillDisappearHandler: UIViewControllerRepresentable {

    let onWillDisappear: () -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        ViewWillDisappearViewController(onWillDisappear: onWillDisappear)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    private class ViewWillDisappearViewController: UIViewController {
        let onWillDisappear: () -> Void

        init(onWillDisappear: @escaping () -> Void) {
            self.onWillDisappear = onWillDisappear
            super.init(nibName: nil, bundle: nil)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            onWillDisappear()
        }
    }
}

private struct WillAppearHandler: UIViewControllerRepresentable {

    let onWillAppear: () -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        ViewWillAppearViewController(onWillAppear: onWillAppear)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    private class ViewWillAppearViewController: UIViewController {
        let onWillAppear: () -> Void

        init(onWillAppear: @escaping () -> Void) {
            self.onWillAppear = onWillAppear
            super.init(nibName: nil, bundle: nil)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            onWillAppear()
        }
    }
}
