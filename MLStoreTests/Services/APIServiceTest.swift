//
//  APIServiceTest.swift
//  MLStoreTests
//
//  Created by Diego Sepulveda on 22-04-24.
//

import XCTest
@testable import MLStore

final class APIServiceTest: XCTestCase {

    var mockAPIService: APIService!
    var session: URLSession!
    var bundle: Bundle!

    override func setUp() {
        super.setUp()
        session = {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.protocolClasses = [MockURLProtocol.self]
            return URLSession(configuration: configuration)
        }()
        bundle = Bundle(for: type(of: self))
        mockAPIService = MLAPIService(session: session)
    }

    override func tearDown() {
        mockAPIService = nil
        session = nil
        bundle = nil
        MockURLProtocol.requestHandler = nil
        super.tearDown()
    }

    func test_products_shouldReturnOne() async throws {
        let path = bundle.path(forResource: "products_one_item", ofType: "json")

        let mockData = try? Data(contentsOf: URL(fileURLWithPath: path!))

        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url?.absoluteString, "https://api.mercadolibre.com/sites/MLA/search?q=iphone15")

            // Return a mocked response
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, mockData!)
        }

        // Act
        let products = try await mockAPIService.fetchProducts("iphone15", sort: "")

        // Assert
        XCTAssertNotNil(products)
        XCTAssertTrue(products.results.count == 1)
    }

    func test_products_shouldReturnZero() async throws {
        let path = bundle.path(forResource: "products_zero_items", ofType: "json")

        let mockData = try? Data(contentsOf: URL(fileURLWithPath: path!))

        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url?.absoluteString, "https://api.mercadolibre.com/sites/MLA/search?q=")

            // Return a mocked response
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, mockData!)
        }

        // Act
        let products = try await mockAPIService.fetchProducts("", sort: "")

        // Assert
        XCTAssertNotNil(products)
        XCTAssertNotNil(products.paging)
        XCTAssertTrue(products.paging!.total == 0)
        XCTAssertTrue(products.results.isEmpty)
    }


    func test_products_shouldReturnInvalidResponse() async throws {
        let path = bundle.path(forResource: "products_zero_items", ofType: "json")

        let mockData = try? Data(contentsOf: URL(fileURLWithPath: path!))

        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url?.absoluteString, "https://api.mercadolibre.com/sites/MLA/search?q=")

            // Return a mocked response
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 404,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, mockData!)
        }

        // Act
        do {
            _ = try await mockAPIService.fetchProducts("", sort: "")
            XCTFail()
        } catch {
            XCTAssertTrue(error is NetworkError)
            XCTAssertTrue((error as! NetworkError) == .invalidResponse)
        }
    }

    func test_products_shouldReturnDecodingError() async throws {
        let path = bundle.path(forResource: "products_corrupted_data", ofType: "json")

        let mockData = try? Data(contentsOf: URL(fileURLWithPath: path!))

        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url?.absoluteString, "https://api.mercadolibre.com/sites/MLA/search?q=")

            // Return a mocked response
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, mockData!)
        }

        // Act
        do {
            _ = try await mockAPIService.fetchProducts("", sort: "")
            XCTFail()
        } catch {
            XCTAssertTrue(error is NetworkError)
            XCTAssertTrue((error as! NetworkError) == .decodingError)
        }
    }

}

