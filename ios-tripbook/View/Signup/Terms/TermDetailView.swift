//
//  TermDetailView.swift
//  ios-tripbook
//
//  Created by 이시원 on 3/20/24.
//

import SwiftUI
import UIKit
import WebKit
import SnapKit

struct TermDetailView: UIViewControllerRepresentable {
    let url: URL
    func makeUIViewController(context: Context) -> UIViewController {
        return WebViewViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

fileprivate class WebViewViewController: UIViewController {
    private var webView: WKWebView!
    private var progressView: UIProgressView!
    let url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.webView.removeObserver(
            self,
            forKeyPath: #keyPath(WKWebView.estimatedProgress)
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.progressView = UIProgressView()
        self.progressView.trackTintColor = .lightGray
        self.progressView.progressTintColor = .systemBlue
        self.progressView.progress = 0.0
        
        self.webView = WKWebView()
        let request = URLRequest(
            url: url,
            cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy
        )
        self.webView.load(request)
        self.view.addSubview(progressView)
        self.view.addSubview(webView)
        progressView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        webView.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom)
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.webView.addObserver(
            self,
            forKeyPath: #keyPath(WKWebView.estimatedProgress),
            options: .new,
            context: nil
        )
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        progressView.setProgress(Float((self.webView.estimatedProgress)), animated: true)
        if progressView.progress == 1.0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.progressView.isHidden = true
            }
        }
    }
}
