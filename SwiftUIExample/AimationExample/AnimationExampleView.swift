//
//  AnimationExampleView.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 13.06.2024.
//

import SwiftUI

struct AnimationExampleView: View {
    
    @State var buttonTapped: Bool = false
    
    var body: some View {
        Button("Click") {
            /// example of explicitly animation
//            withAnimation {
//                buttonTapped.toggle()
//            }
            
            buttonTapped.toggle()
        }
        .padding()
        .background(.blue)
        .foregroundStyle(buttonTapped ? .green : .white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        /// implicitly animation. foregroundStyle will be with animation bellow
        .animation(.default, value: buttonTapped)
        .scaleEffect(buttonTapped ? 0.8 : 1)
        /// implicitly animation. scaleEffect will be with animation bellow
        .animation(.easeInOut(duration: 1.0), value: buttonTapped)
    }
}

#Preview {
    AnimationExampleView()
}
