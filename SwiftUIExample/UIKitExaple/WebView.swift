//
//  WebView.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 24.05.2024.
//

import SwiftUI
import WebKit
import Foundation


// MARK: - Example view from UIKit
struct WebView: UIViewRepresentable {
    
    /// this is mistake, we don't need create value
    ///var webView: WKWebView?, we create view in makeUIView
    
    let url: URL
    var navigationPolicy: ((WKNavigationAction) -> WKNavigationActionPolicy?)? = nil
    
    /// part of UIViewRepresentable
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // first in lifecycle
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.load(URLRequest(url: url))
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView,
                     decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(parent.navigationPolicy?(navigationAction) ?? .allow)
        }
    }
}

extension WebView {
    func set(navigationPolicy: @escaping (WKNavigationAction) -> WKNavigationActionPolicy) -> WebView {
        var copy = self
        copy.navigationPolicy = navigationPolicy
        return copy
    }
}
