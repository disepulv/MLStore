//
//  ContentView.swift
//  MLStore
//
//  Created by Diego Sepulveda on 18-04-24.
//

import SwiftUI

struct ProductSearchView: View {
    @State var searchText: String = ""
    
    var body: some View {
        VStack {
            TextField("Product name or description", text: $searchText)
                .multilineTextAlignment(.center)
            Button("Search") {
                print("Searching...")
            }
        }
        .padding()
    }
}

#Preview {
    ProductSearchView()
}
