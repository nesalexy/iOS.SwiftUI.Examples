//
//  TodoItemRow.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 15.05.2024.
//

import SwiftUI

struct ListExampleItemRow: View {
    
    @Binding var item: ListExampleItem
    
    var body: some View {
        HStack {
            ListExampleToggleButton(state: $item.isDone)
                .frame(width: 20, height: 20)
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                    .strikethrough(item.isDone)
                
                if let description = item.description {
                    Text(description)
                        .font(.subheadline)
                        .strikethrough(item.isDone)
                }
            }
            .padding([.leading, .top, .bottom])
            .frame(maxWidth: .infinity,
                   alignment: .leading)
        }
    }
}

// MARK: - Example for two previews

#Preview(traits: .sizeThatFitsLayout) {
    
    ListExampleItemRow(item: .constant(.init(id: UUID(),
                                      title: "Item",
                                      description: "Description")))
    .previewDisplayName("With description")
}

#Preview(traits: .sizeThatFitsLayout) {
    
    ListExampleItemRow(item: .constant(.init(id: UUID(),
                                      title: "Item")))
    .previewDisplayName("Without description")
}
