//
//  TextFieldInputPreferenceKey.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 24.05.2024.
//

import Foundation
import SwiftUI


struct TextFieldInputPreferenceKey: PreferenceKey {
    
    static let defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
    
}

