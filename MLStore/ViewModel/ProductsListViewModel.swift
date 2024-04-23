//
//  ProductListViewModel.swift
//  MLStore
//
//  Created by Diego Sepulveda on 22-04-24.
//

import SwiftUI

public class ProductsListViewModel: ObservableObject {
    @Published public var response: ProductResponse?
    @Published public var errorMsg: String = ""
    @Published public var query: String
    @Published public var sort: String = ""

    private let service: APIService

    public init(service: APIService = MLAPIService.shared, query: String) {
        self.service = service
        self.query = query
    }

    @MainActor
    public func fetchProductsByQuery() async {
        do {
            let fetchedProducts = try await service.fetchProducts(query, sort: sort)
            self.response = fetchedProducts
        } catch NetworkError.invalidResponse {
            errorMsg = "Se ha producido un error al buscar productos. Favor intenta más tarde"
        } catch NetworkError.decodingError {
            errorMsg = "Se ha producido un error al cargar productos. Favor intenta más tarde"
        } catch NetworkError.connectionError {
            errorMsg = "No es posible conectar con el servidor. Favor intenta más tarde"
        } catch {
            errorMsg = "Error inesperado. Favor intenta más tarde"
        }
    }
}
