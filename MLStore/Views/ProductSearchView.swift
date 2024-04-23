//
//  ContentView.swift
//  MLStore
//
//  Created by Diego Sepulveda on 18-04-24.
//

import SwiftUI

struct ProductSearchView: View {
    @EnvironmentObject private var navigationState: NavigationState
    @State var query: String = ""
    @State var disabledButton = true
    
    var body: some View {
        VStack {
            TextField("Product name or description", text: $query)
                .multilineTextAlignment(.center)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .accessibility(identifier: "searchField")

            Button(action: {
                navigationState.routes.append(.products(query: query))
            }, label: {
                Text("Search")
                    .frame(maxWidth: .infinity)
                    .frame(height: 35)
            })
            .disabled(disabledButton)
            .buttonStyle(.borderedProminent)
            .accessibility(identifier: "searchButton")
        }
        .onChange(of: query, {
            disabledButton = query.count == 0
        })
        .padding()
        .navigationTitle("Search")
    }
}

#Preview {
    ProductSearchView()
}
