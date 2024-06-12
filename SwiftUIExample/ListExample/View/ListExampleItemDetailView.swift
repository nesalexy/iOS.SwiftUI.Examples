//
//  TodoItemDetailView.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 16.05.2024.
//

import SwiftUI

struct ListExampleItemDetailView: View {
    
    @Binding var item: ListExampleItem
    
    var body: some View {
        Form {
            TextField("Title", text: $item.title)
                .font(.headline)
            
            TextField("Description", text: $item.description.whenEmpty(""))
                .font(.subheadline)
        }
        .navigationTitle("Edit")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                
            }
        }
    }
}

#Preview {
    ListExampleItemDetailView(item: .constant(.init(id: UUID(),
                                             title: "Test"))
    )
}
