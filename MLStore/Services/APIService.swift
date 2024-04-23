//
//  ProductService.swift
//  MLStore
//
//  Created by Diego Sepulveda on 18-04-24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case connectionError
    case decodingError
}

public protocol APIService {
    static var shared: APIService { get }
    var baseURL: String { get set }
    var session: URLSession { get set }

    func fetchProducts(_ query: String, sort: String) async throws -> ProductResponse
}

public class MLAPIService: APIService {

    public var baseURL = "https://api.mercadolibre.com/sites/MLA/"

    public var session: URLSession

    public static let shared: APIService = MLAPIService()

    init(
        session: URLSession = URLSession.shared
    ) {
        self.session = session
    }

    public func fetchProducts(_ query: String, sort: String = "") async throws -> ProductResponse {
        guard var url = URL(string: baseURL + "search") else {
            throw NetworkError.invalidURL
        }

        url.append(queryItems: [URLQueryItem(name: "q", value: query)])
        if !sort.isEmpty {
            url.append(queryItems: [URLQueryItem(name: "sort", value: sort)])
        }

        guard let (data, response) = try? await session.data(from: url) else {
            throw NetworkError.connectionError
        }

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        guard let fetchedProducts = try? JSONDecoder().decode(ProductResponse.self, from: data) else {
            throw NetworkError.decodingError
        }

        return fetchedProducts
    }
}
