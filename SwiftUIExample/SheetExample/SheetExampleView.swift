//
//  AboutView.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 16.05.2024.
//

import SwiftUI

struct SheetExampleView: View {
    
    @Environment(\.analytics) var analytics: Analytics
    
    @State var isMoreInfoPresented = false
    
    var body: some View {
        VStack {
            Text("About Me 🐗")
                .padding()
            
            Button("More?") {
                isMoreInfoPresented = true
            }
        }
        .onAppear {
            analytics.send(tag: "SheetExampleView")
        }
        /// sheet for full screen
//        .sheet(isPresented: $isMoreInfoPresented, content: {
//            MoreInfoView()
//        })
        
        /// sheet for half screen
        .sheet(isPresented: $isMoreInfoPresented, content: {
            SheetExampleMoreInfoView()
                ///  iOS >= 16
                .presentationDetents([.medium]) // or .traction(0.2), ...
        })
    }
    
    func test() -> Void {
        
    }
}

#Preview {
    SheetExampleView()
}
