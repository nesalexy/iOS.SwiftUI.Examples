//
//  UKitViewExample.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 24.05.2024.
//

import SwiftUI

/// Example UIKIt in SwiftUI
struct UKitViewExample: View {
    var body: some View {
        VStack {
            WebView(url: URL(string: "https://www.youtube.com/")!)
                /// example callback closure
                .set(navigationPolicy: { navigationAction in
                    navigationAction.navigationType == .linkActivated ? .cancel : .allow
                })
            
            /// SwiftUI code in UIKIt example
            SwiftUIinUIKitExampleRepresentable()
        }
       
    }
}

#Preview {
    UKitViewExample()
}
