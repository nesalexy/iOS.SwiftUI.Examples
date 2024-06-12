//
//  Analytics.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 17.05.2024.
//

import Foundation


class Analytics {
    func send(tag: String) {
        print("Send \(tag) analytic")
    }
}

class MockAnalytics: Analytics {
    override func send(tag: String) {
        print("override send")
    }
}
