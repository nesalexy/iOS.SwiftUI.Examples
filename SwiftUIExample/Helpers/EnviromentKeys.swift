//
//  EnviromentKeys.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 17.05.2024.
//

import Foundation
import SwiftUI

// Example EnvironmentKey for own services
// doesn't work for ObservableObject object
private struct AnalyticsEnvironmentKey: EnvironmentKey {
    static let defaultValue: Analytics = Analytics()
}

extension EnvironmentValues {
    var analytics: Analytics {
        get { self[AnalyticsEnvironmentKey.self] }
        set { self[AnalyticsEnvironmentKey.self] = newValue }
    }
}
