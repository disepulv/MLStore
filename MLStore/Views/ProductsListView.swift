//
//  ProductsListView.swift
//  MLStore
//
//  Created by Diego Sepulveda on 18-04-24.
//

import SwiftUI

struct ProductsListView: View {
    @EnvironmentObject private var navigationState: NavigationState
    @ObservedObject var productsListViewModel: ProductsListViewModel

    var body: some View {
        HStack {
            MLText("\(productsListViewModel.response?.paging?.total ?? 0) \(Constants.Products.resultsLabel)")
            Spacer()
            Menu(Constants.Products.filterLabel) {
                Menu(Constants.Products.sortByLabel) {
                    if let sort = productsListViewModel.response?.sort {
                        Button(sort.name, action: { sortProducts(sort.id) })
                    }

                    ForEach(productsListViewModel.response?.availableSorts ?? [], id: \.self) { sort in
                        Button(sort.name, action: { sortProducts(sort.id) })
                    }
                }
            }
        }
        .padding()

        HStack {
            if productsListViewModel.errorMsg.isNotEmpty {
                MLText(productsListViewModel.errorMsg, style: .textMDRegular)
                        .frame(maxWidth: .infinity)
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.5))
            }
        }

        ZStack {
            List {
                ForEach(productsListViewModel.response?.results ?? [], id: \.self) { product in
                    ProductListCellView(product: product)
                        .onTapGesture {
                            navigationState.routes.append(.detail(product: product))
                        }
                }
            }

            if productsListViewModel.response == nil {
                VStack {
                    ProgressView()
                    MLText(Constants.Products.loadingLabel)
                }
            }

            if productsListViewModel.response != nil && productsListViewModel.response!.results.isEmpty {
                VStack (spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    MLText(Constants.Products.noResultsTitleLabel)
                    MLText(Constants.Products.noResultsDescLabel, style: .textXSRegular)
                }
                .padding()
            }
        }
        .task {
            await productsListViewModel.fetchProductsByQuery()
        }
        .navigationTitle(Constants.Products.productsTitle)
    }

    func sortProducts(_ sort: String) {
        productsListViewModel.sort = sort
        productsListViewModel.response = nil
        Task {
            await productsListViewModel.fetchProductsByQuery()
        }
    }
}

#Preview {
    ProductsListView(productsListViewModel: ProductsListViewModel(query: "iphone 15"))
}
