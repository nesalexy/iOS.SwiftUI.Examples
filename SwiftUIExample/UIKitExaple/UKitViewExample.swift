//
//  UKitViewExample.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 24.05.2024.
//

import SwiftUI

/// Example callback from UIKit View
struct UKitViewExample: View {
    var body: some View {
        WebView(url: URL(string: "https://nesterchuk-oleksii.com")!)
            .set(navigationPolicy: { navigationAction in
                navigationAction.navigationType == .linkActivated ? .cancel : .allow
            })
    }
}

#Preview {
    UKitViewExample()
}
