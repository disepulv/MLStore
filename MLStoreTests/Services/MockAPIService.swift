//
//  MockAPIService.swift
//  MLStoreTests
//
//  Created by Diego Sepulveda on 22-04-24.
//

import XCTest
import MLStore

public class MockAPIService: APIService {

    public var baseURL = "https://test.mercadolibre.com/sites/MLA/"

    public var session: URLSession

    public static let shared: APIService = MockAPIService()

    init(
        session: URLSession = URLSession.shared
    ) {
        self.session = session
    }

    public func fetchProducts(_ query: String, sort: String) async throws -> ProductResponse {
        let bundle = Bundle(for: type(of: self))

        let path = bundle.path(forResource: query, ofType: "json")

        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
            
        let fetchedProducts = try JSONDecoder().decode(ProductResponse.self, from: data!)

        return fetchedProducts
    }
}
