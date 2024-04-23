//
//  Constants.swift
//  MLStore
//
//  Created by Diego Sepulveda on 23-04-24.
//

import Foundation

struct Constants {
    enum Search {
        static let searchLabel = "Product name or description".localized
        static let searchButton = "Search".localized
        static let searchTitle = "Search".localized
    }

    enum Products {
        static let filterLabel = "Filter".localized
        static let sortByLabel = "Sort by:".localized
        static let loadingLabel = "Loading...".localized
        static let productsTitle = "Results".localized
        static let resultsLabel = "results".localized
        static let noResultsTitleLabel = "No publications were found...".localized
        static let noResultsDescLabel = "Check correct spell...".localized
    }

    enum ProductDetail {
        static let shareTitleLabel = "Look at this product".localized
        static let buyNowLabel = "Buy now".localized
        static let addToCartLabel = "Add to cart".localized
        static let detailTitle = "Detail".localized
    }
}
