//
//  WebView.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 24.05.2024.
//

import SwiftUI
import WebKit


// MARK: - Example view from UIKit
struct WebView: UIViewRepresentable {
    
    /// this is mistake, we don't need create value
    ///var webView: WKWebView?
    
    // first in lifecycle
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
