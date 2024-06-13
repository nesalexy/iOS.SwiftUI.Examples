//
//  ParentView.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 16.05.2024.
//

import SwiftUI

struct AppTabView: View {
    
    private let analytics = Analytics()
    
    enum Tab: Hashable {
        case todos
        case about
    }
    
    @State var selectedTab: Tab = .todos
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ListExampleItemsListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List Example")
                }
                .tag(Tab.todos)
            
            VStack {
                PassDataThrowsEnvironmentExampleParentView()
                    .frame(height: 200)
                SheetExampleView()
            }
            .tabItem {
                Image(systemName: "questionmark.circle.fill")
                Text("About")
            }
            .tag(Tab.about)
            // MARK: - Example override global instance of service
            .environment(\.analytics, MockAnalytics())
            
            PassDataThrowsEnvironmentExampleParentView()
                .tabItem {
                    Image(systemName: "highlighter")
                    Text("Animations")
                }
            
            CalculateWidthBasedOnLargestView()
                .tabItem {
                    Image(systemName: "scribble.variable")
                    Text("Max Width")
                }
            
            UKitViewExample()
                .tabItem {
                    Image(systemName: "globe")
                    Text("UIKit")
                }
            
        }
        .onChange(of: selectedTab) {
            print(selectedTab)
        }
    }
}

#Preview {
    AppTabView()
}
