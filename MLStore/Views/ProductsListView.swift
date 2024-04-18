//
//  ProductsListView.swift
//  MLStore
//
//  Created by Diego Sepulveda on 18-04-24.
//

import SwiftUI

struct ProductsListView: View {
    @EnvironmentObject private var navigationState: NavigationState

    var body: some View {
        Text("Products list view!")
        Button("Detail") {
            print("loading detail...")
            navigationState.routes.append(.detail)
        }
    }
}

#Preview {
    ProductsListView()
}
