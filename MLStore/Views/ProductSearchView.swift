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
            TextField(Constants.Search.searchLabel, text: $query)
                .frame(height: 55)
                .textFieldStyle(PlainTextFieldStyle())
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                .multilineTextAlignment(.center)
                .accessibility(identifier: "searchField")

            Button(action: {
                navigationState.routes.append(.products(query: query))
            }, label: {
                Text(Constants.Search.searchButton)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
            })
            .disabled(disabledButton)
            .buttonStyle(.borderedProminent)
            .accessibility(identifier: "searchButton")
        }
        .onChange(of: query, {
            disabledButton = query.count == 0
        })
        .padding()
        .navigationTitle(Constants.Search.searchTitle)
    }
}

#Preview {
    ProductSearchView()
}
