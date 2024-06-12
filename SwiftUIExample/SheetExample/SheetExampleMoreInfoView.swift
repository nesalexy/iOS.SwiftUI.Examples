//
//  MoreInfoView.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 16.05.2024.
//

import SwiftUI

struct SheetExampleMoreInfoView: View {
    /// bad solution
    //@Binding var isPresented: Bool
    
    /// good solution
    @Environment(\.dismiss) var dismiss ///  iOS >= 15
    //@Environment(\.presentationMode) var presentationMode /// iOS < 15
    
    var body: some View {
        Button("Dismiss") {
            /// bad solution
            //isPresented = false
            
            /// good solution, iOS >= 15
            dismiss()
            
            /// good solution,  iOS < 15
            //presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    SheetExampleMoreInfoView()
}
