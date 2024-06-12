//
//  struct MaxWidthPreferenceKey.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 24.05.2024.
//

import Foundation
import SwiftUI

struct MaxWidthPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        /// contains max value
        value = max(value, nextValue())
    }
    
}
