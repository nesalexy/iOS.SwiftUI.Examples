//
//  PassDataThrowsEnvironmentExampleChildView.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 24.05.2024.
//

import SwiftUI

struct PassDataThrowsEnvironmentExampleChildView: View {
    
    @State var text = ""
    
    var body: some View {
        Form {
            TextField("Write something", text: $text)
        }
        .textFieldInput(text)
    }
}

extension View {
    func textFieldInput(_ textInput: String) -> some View {
        self.preference(key: TextFieldInputPreferenceKey.self, value: textInput)
    }
}

#Preview {
    PassDataThrowsEnvironmentExampleChildView()
}
