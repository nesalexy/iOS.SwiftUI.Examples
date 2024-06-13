//
//  TableViewController.swift
//  SwiftUIExample
//
//  Created by Alexy Nesterchuk on 13.06.2024.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI

/// Representable ViewController for SwiftUI
struct SwiftUIinUIKitExampleRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> SwiftUIinUIKitExample {
        /// Return  instance
        SwiftUIinUIKitExample()
    }
    
    func updateUIViewController(_ uiViewController: SwiftUIinUIKitExample, context: Context) {
        /// Updates the state of the specified view controller with new information from SwiftUI.
    }
}

final class SwiftUIinUIKitExample: UIViewController {
    
    private var items = (0...10).map({ $0 })
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// setup tableview
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        
        tableView.dataSource = self
    }
}

extension SwiftUIinUIKitExample: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        /// SwiftUI Code in UIKIt
        let configuration: UIHostingConfiguration = UIHostingConfiguration {
            VStack {
                Text("SwiftUI Text Item \(items[indexPath.row])")
            }
        }
        
        cell.contentConfiguration = configuration
        return cell
    }
}
