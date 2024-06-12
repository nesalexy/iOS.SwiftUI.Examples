//
//  SwiftUIExampleApp.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 15.05.2024.
//

import SwiftUI

@main
struct SwiftUIExampleApp: App {
    
    var body: some Scene {
        WindowGroup {
            AppTabView()
                // MARK: - Example with global instance of service
                .environment(\.analytics, Analytics())
        }
    }
}
