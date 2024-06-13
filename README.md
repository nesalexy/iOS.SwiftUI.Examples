# Different basic SwiftUI examples.

Even though I was already working with SwiftUI, for more understanding I decided to take a [course](https://vpradeilles.gumroad.com/l/learning-swiftui-when-you-already-know-uikit) that includes **10+** hours of different examples. 

The **repository** includes examples of **different examples**. 
I recommend checking out this [course](https://vpradeilles.gumroad.com/l/learning-swiftui-when-you-already-know-uikit), even if you've already worked with SwiftUI.

### Example 1
How to calculate the width of an element by the widest element?
1. Using `GeometryReader`
2. Create **own settings** for view
```
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
```
and **using** 
```
 SyncingView { proxy in
            Group {
                Button("Login") {}
                Button("Register sadasd") {}
            }
            .syncWidth(using: proxy) /// using here
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(15)
            .font(.headline)
```

### Example 2

Example for two previews in the **same** View. 
For example, when you want to display a view with **different data**

```
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
```

### Example 3
Example when you need to pass an **@Binding** object from a list

```
NavigationStack {
            List {
                ForEach($viewModel.todoItems, id:\.id) { $todoItem in
                    NavigationLink(value: todoItem) {
                        ListExampleItemRow(item: $todoItem.onNewValue {
                            viewModel.reorder()
                        })
                    }
                }
            }
            .navigationDestination(for: ListExampleItem.self, destination: { todoItem in
                /// example generation binding object
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
            /// rest of code
        }
```

List item

```
struct ListExampleItemRow: View {
    
    @Binding var item: ListExampleItem
    
    /// rest of code
}
```

### Example 4

Example with dismiss **sheet**

```
@State var isMoreInfoPresented = false
    
    var body: some View {
        VStack {
            Text("About Me 🐗")
                .padding()
            
            Button("More?") {
                isMoreInfoPresented = true
            }
        }
        .sheet(isPresented: $isMoreInfoPresented, content: {
            SheetExampleMoreInfoView()
                ///  iOS >= 16
                .presentationDetents([.medium]) // or .traction(0.2), ...
        })
    }
```

and sheet view

```
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
```

### Example 5

Transferring data from the child element to the parent element. 
We can use:
1. @Binding
2. PreferenceKey

**PreferenceKey example**
```
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
```
```
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
```
```
struct TextFieldInputPreferenceKey: PreferenceKey {
    
    static let defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
    
}
```

### Example 6
**UIViewRepresentable** should be used to display **view** elements from **UIKit**

Example with WKWebView(from UIKit) and callback closure

```
struct UKitViewExample: View {
    var body: some View {
        
        WebView(url: URL(string: "https://www.youtube.com/")!)
        /// example callback closure
            .set(navigationPolicy: { navigationAction in
                navigationAction.navigationType == .linkActivated ? .cancel : .allow
            })
        
    }
}
```

```
struct WebView: UIViewRepresentable {
    
    /// this is mistake, we don't need create value
    ///var webView: WKWebView?, we create view in makeUIView
    
    let url: URL
    var navigationPolicy: ((WKNavigationAction) -> WKNavigationActionPolicy?)? = nil
    
    /// part of UIViewRepresentable
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // first in lifecycle
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.load(URLRequest(url: url))
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView,
                     decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(parent.navigationPolicy?(navigationAction) ?? .allow)
        }
    }
}

extension WebView {
    /// example callback closure 
    func set(navigationPolicy: @escaping (WKNavigationAction) -> WKNavigationActionPolicy) -> WebView {
        var copy = self
        copy.navigationPolicy = navigationPolicy
        return copy
    }
}
```

### Example 7
**UIViewControllerRepresentable** should be used to display **ViewController**(s) elements from **UIKit**
```
/// Representable ViewController for SwiftUI
struct SwiftUIinUIKitExampleRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> MyViewController {
        /// Return  instance of ViewController
    }
    
    func updateUIViewController(_ uiViewController: MyViewController, context: Context) {
        /// Updates the state of the specified view controller with new information from SwiftUI.
    }
}
```

### Example 8
Example of displaying SwiftUI element inside UIKit TableView
```
extension SwiftUIinUIKitExample: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        /// SwiftUI Code in UIKIt
        let configuration: UIHostingConfiguration = UIHostingConfiguration {
            VStack {
                Text("SwiftUI here")
                Text("SwiftUI Text Item \(items[indexPath.row])")
            }
        }
        
        cell.contentConfiguration = configuration
        return cell
    }
}
```

### Example 9
Aniamtions
1. Explicitly animation
```
@State var buttonTapped: Bool = false
    
    var body: some View {
        Button("Click") {
            /// example of explicitly animation
            withAnimation {
                buttonTapped.toggle()
            }        }
        .padding()
        .background(.blue)
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .scaleEffect(buttonTapped ? 0.8 : 1)
    }
```
2. Implicitly animation
```
@State var buttonTapped: Bool = false
    
    var body: some View {
        Button("Click") {
            buttonTapped.toggle()
        }
        .padding()
        .background(.blue)
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .scaleEffect(buttonTapped ? 0.8 : 1)
        /// example of implicitly animation, must be at the bottom
        .animation(.default, value: buttonTapped)
    }
```
3. Multiple animations in one view
```
var body: some View {
        Button("Click") {
            buttonTapped.toggle()
        }
        .padding()
        .background(.blue)
        .foregroundStyle(buttonTapped ? .green : .white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        /// foregroundStyle will be with animation bellow
        .animation(.default, value: buttonTapped)
        /// .animation(nil, value: buttonTapped) - for remove all animations before
        .scaleEffect(buttonTapped ? 0.8 : 1)
        /// scaleEffect will be with animation bellow
        .animation(.easeInOut(duration: 1.0), value: buttonTapped)
    }
```
