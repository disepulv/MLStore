//
//  MLStoreApp.swift
//  MLStore
//
//  Created by Diego Sepulveda on 18-04-24.
//

import SwiftUI

enum Route: Hashable {
    case search
    case products(query: String)
    case detail(product: Product)
}

class NavigationState: ObservableObject {
    @Published var routes: [Route] = []
}

@main
struct MLStoreApp: App {
    @StateObject private var navigationState = NavigationState()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationState.routes) {
                ProductSearchView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .search:
                            ProductSearchView()
                        case .products(let query):
                            ProductsListView(productsListViewModel: ProductsListViewModel(query: query))
                        case .detail(let product):
                            ProductDetailView(product: product)
                        }
                    }
            }
            .environmentObject(navigationState)
        }
    }
}
