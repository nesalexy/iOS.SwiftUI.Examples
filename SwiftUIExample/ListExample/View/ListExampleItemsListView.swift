//
//  ContentView.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 15.05.2024.
//

import SwiftUI

struct ListExampleItemsListView: View {
    
    @StateObject var viewModel = ListExampleViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($viewModel.todoItems, id:\.id) { $todoItem in
                    NavigationLink(value: todoItem) {
                        ListExampleItemRow(item: $todoItem.onNewValue {
                            viewModel.reorder()
                        })
                    }
                }
                .onDelete(perform: viewModel.deleteItems(at:))
                .onMove(perform: viewModel.moveItems(from:to:))
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Today's tasks")
            
            // MARK: - Example getting item by id, making binding object
            
            .navigationDestination(for: ListExampleItem.self, destination: { todoItem in
                let todoItemBinding = Binding(
                    get: {
                        viewModel.todoItems.first(where: { $0.id == todoItem.id })!
                    },
                    set: { newItem in
                        let index = viewModel.todoItems.firstIndex(where: { $0.id == todoItem.id })!
                        viewModel.todoItems[index] = newItem
                    }
                )
                ListExampleItemDetailView(item: todoItemBinding)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .onAppear {
                viewModel.loadItems()
            }
        }
    }
}

#Preview {
    ListExampleItemsListView(viewModel: ListExampleViewModel())
}
