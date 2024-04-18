//
//  MLStoreApp.swift
//  MLStore
//
//  Created by Diego Sepulveda on 18-04-24.
//

import SwiftUI

enum Route: Hashable {
    case search
    case products
    case detail
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
                        case .products:
                            ProductsListView()
                        case .detail:
                            ProductDetailView()
                        }
                    }
            }
            .environmentObject(navigationState)
        }
    }
}
