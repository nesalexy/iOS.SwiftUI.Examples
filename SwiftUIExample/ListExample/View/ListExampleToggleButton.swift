//
//  TodoToggleButton.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 16.05.2024.
//

import SwiftUI

struct ListExampleToggleButton: View {
    
    @Binding var state: Bool
    
    var body: some View {
        Button {
            withAnimation {
                state.toggle()
            }
        } label: {
            GeometryReader { proxy in /// for ".frame(width: proxy.size.width * 0.8)"
                ZStack {
                    Circle()
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(.blue)
                    
                    if state {
                        Circle()
                            .frame(width: proxy.size.width * 0.8)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        //.padding(8)
        .scaledToFit() /// take size only what you need
        .buttonStyle(.borderless) /// need for tap on this separately view in item list
    }
}

// MARK: - Example for two previews

#Preview(traits: .sizeThatFitsLayout)  {
    ListExampleToggleButton(state: .constant(false))
}

#Preview(traits: .sizeThatFitsLayout)  {
    ListExampleToggleButton(state: .constant(true))
}
