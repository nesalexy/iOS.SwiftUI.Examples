//
//  PassDataThrowsEnvorimentExampleParentView.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 24.05.2024.
//

import SwiftUI

// MARK: - Example update data in ParentView from ChildView without @Binding
struct PassDataThrowsEnvironmentExampleParentView: View {
    
    @State var textInput = ""
    
    var body: some View {
        VStack {
            Text("Text from child: \(textInput)")
            
            HStack {
                PassDataThrowsEnvironmentExampleChildView()
            }
        }
        .onPreferenceChange(TextFieldInputPreferenceKey.self) { newValue in
            textInput = newValue
        }
    }
}

#Preview {
    PassDataThrowsEnvironmentExampleParentView()
}
