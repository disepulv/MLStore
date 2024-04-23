//
//  ProductsListViewModel.swift
//  MLStoreTests
//
//  Created by Diego Sepulveda on 22-04-24.
//

import XCTest
import MLStore

final class ProductsListViewModelTest: XCTestCase {

    var viewModel: ProductsListViewModel!
    var service: APIService!

    override func setUp() {
        super.setUp()
        service = MockAPIService()
    }

    override func tearDown() {
        service = nil
        viewModel = nil
        super.tearDown()
    }

    func test_products_shouldReturnZero() async throws {

        viewModel = ProductsListViewModel(service: service, query: "products_zero_items")

        await viewModel.fetchProductsByQuery()

        XCTAssertNotNil(viewModel.response)
        XCTAssertNotNil(viewModel.response!.results)
        XCTAssertTrue(viewModel.response!.results.isEmpty)
    }

    func test_products_shouldReturnOne() async throws {

        viewModel = ProductsListViewModel(service: service, query: "products_one_item")

        await viewModel.fetchProductsByQuery()

        XCTAssertNotNil(viewModel.response)
        XCTAssertNotNil(viewModel.response!.results)
        XCTAssertTrue(viewModel.response!.results.count == 1)
    }

}
