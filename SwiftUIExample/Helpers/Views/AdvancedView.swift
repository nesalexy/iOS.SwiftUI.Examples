//
//  AdvancedView.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 15.05.2024.
//

import SwiftUI

// MARK: - Example for centralize views by some view

extension VerticalAlignment {
    enum AccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    static let midAccountAndName = VerticalAlignment(AccountAndName.self)
}

struct AdvancedView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            
            VStack {
                Text("Text")
                    .alignmentGuide(.midAccountAndName) { d in
                        d[VerticalAlignment.center]
                    }
                    .background(Color.blue)
                Image("background")
                    .resizable()
                    .frame(width: 64, height: 64)
                    .background(Color.yellow)
            }
            
            VStack {
                Text("Full name:")
                    .background(Color.red)
                Text("Oleksii Nesterchuk")
                    .alignmentGuide(.midAccountAndName) { d in
                        d[VerticalAlignment.center]
                    }
                    .font(.largeTitle)
                    .background(Color.green)
            }
        }
    }
}

#Preview {
    AdvancedView()
}
