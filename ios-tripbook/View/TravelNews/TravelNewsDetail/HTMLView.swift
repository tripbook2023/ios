//
//  WebView.swift
//  ios-tripbook
//
//  Created by RED on 2023/12/07.
//

import SwiftUI
import WebKit
import SnapKit

struct HTMLView: UIViewRepresentable {
    let htmlString: String
    @Binding var contentHeight: CGFloat
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: HTMLView
        
        init(_ parent: HTMLView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            let height = webView.scrollView.contentSize.height
            self.parent.contentHeight = height
        }
    }
}
//
//struct HTMLView: UIViewRepresentable {
//    let htmlString: String
//    @Binding var contentHeight: CGFloat
//
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        webView.navigationDelegate = context.coordinator
//        webView.snp.makeConstraints { make in
//            make.width.equalTo(UIScreen.main.bounds.width)
//        }
//        return webView
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        uiView.loadHTMLString(htmlString, baseURL: nil)
//    }
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(self)
//    }
//
//    class Coordinator: NSObject, WKNavigationDelegate {
//        var parent: HTMLView
//
//        init(_ parent: HTMLView) {
//            self.parent = parent
//        }
//
//        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            let height = webView.scrollView.contentSize.height
//            self.parent.contentHeight = height
//        }
//    }
//}