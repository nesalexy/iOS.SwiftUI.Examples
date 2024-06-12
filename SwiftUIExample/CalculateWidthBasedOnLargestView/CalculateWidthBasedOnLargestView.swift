//
//  LoginViewPassData.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 24.05.2024.
//

import SwiftUI

// MARK: - Display buttons group based on the largest width of the button
struct CalculateWidthBasedOnLargestView: View {
    
//    @State var maxWidth: CGFloat?
    
    var body: some View {
        SyncingView { proxy in
            Group {
                Button("Login") {}
                Button("Register sadasd") {}
            }
//            .background {
//                GeometryReader { proxy in
//                    // EmptyView() -> would not work, need use Color.clear
//                    Color.clear.preference(key: MaxWidthPreferenceKey.self,
//                                           value: proxy.size.width)
//                }
//            }
            .syncWidth(using: proxy)
//            .frame(maxWidth: maxWidth)

            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(15)
            .font(.headline)
        }
//        .onPreferenceChange(MaxWidthPreferenceKey.self) { value in
//            maxWidth = value
//        }
    }
}

#Preview {
    CalculateWidthBasedOnLargestView()
}

// MARK: - Bellow example with allocation all logic for determinate width
struct SyncViewProxy {
    fileprivate var maxWidth: CGFloat?
}

struct SyncingView<Content: View>: View {
    
    @State var proxy = SyncViewProxy()
    
    @ViewBuilder var content: (SyncViewProxy) -> Content
    
    var body: some View {
        VStack {
            content(proxy)
        }
        .onPreferenceChange(MaxWidthPreferenceKey.self) { value in
            proxy.maxWidth = value
        }
    }
}

struct SyncingViewModifier: ViewModifier {
    var proxy: SyncViewProxy
    
    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { proxy in
                    Color.clear.preference(key: MaxWidthPreferenceKey.self,
                                           value: proxy.size.width)
                }
            }
            .frame(maxWidth: proxy.maxWidth)
    }
}

extension View {
    func syncWidth(using proxy: SyncViewProxy) -> some View {
        self.modifier(SyncingViewModifier(proxy: proxy))
    }
}
