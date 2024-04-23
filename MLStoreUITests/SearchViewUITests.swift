//
//  SearchViewUITests.swift
//  MLStoreUITests
//
//  Created by Diego Sepulveda on 23-04-24.
//

import XCTest

final class SearchViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchProduct() throws {
        let app = XCUIApplication()
        let textField = app.textFields["searchField"]
        XCTAssertTrue(textField.exists, "Text field not found")

        textField.tap()
        textField.typeText("iPhone 15")

        XCTAssertEqual(textField.value as! String, "iPhone 15")

        let button = app.buttons["searchButton"]
        XCTAssertTrue(button.exists, "Search button not found")

        button.tap()

        // Checks navigation to ProductsListView
        let resultsViewTitle = app.staticTexts["Results"]
        XCTAssertTrue(resultsViewTitle.waitForExistence(timeout: 5))
    }
}
