//
//  Binding+Extension.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 16.05.2024.
//

import SwiftUI

extension Binding {
    func onNewValue(_ sideEffect: @escaping () -> Void) -> Binding<Value> {
        Binding(
        get: { wrappedValue },
        set: {
            wrappedValue = $0
            sideEffect()
        })
    }
    
    func whenEmpty<Wrapped>(_ defaultValue: Wrapped) -> Binding<Wrapped> where Value == Wrapped? {
        Binding<Wrapped>(
            get: { wrappedValue ?? defaultValue },
            set: { wrappedValue = $0 }
        )
    }
}
