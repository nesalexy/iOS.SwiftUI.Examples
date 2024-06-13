//
//  AnimationExampleView.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 13.06.2024.
//

import SwiftUI

struct ScalingButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}



struct AnimationExampleView: View {
    
    @State var showContent = false
    
    var body: some View {
        VStack {
            Button("Click") {
                withAnimation {
                    showContent.toggle()
                }
                
            }        }

        if showContent {
            VStack {
                Text("Content here")
                Text("Content here")
                Text("Content here")
            }
            //.transition(.slide.combined(with: .opacity)) /// works with withAnimation
            .transition(.asymmetric(insertion: .opacity,
                                    removal: .slide.combined(with: .opacity)))
        }
    }
}

#Preview {
    AnimationExampleView()
}
