//
//  TodoItem.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 15.05.2024.
//

import Foundation


struct ListExampleItem: Hashable, Codable, Identifiable {
    let id: UUID
    var title: String
    var description: String?
    var isDone: Bool = false
}
