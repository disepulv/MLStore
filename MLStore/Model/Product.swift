//
//  Product.swift
//  MLStore
//
//  Created by Diego Sepulveda on 18-04-24.
//

import Foundation

public struct ProductResponse : Codable {
    let siteId : String?
    let countryDefaultTimeZone : String?
    let query : String?
    let paging : Paging?
    let sort : Sort?
    let availableSorts : [Sort]?
    public let results : [Product]

    enum CodingKeys: String, CodingKey {
        case siteId = "site_id"
        case countryDefaultTimeZone = "country_default_time_zone"
        case query = "query"
        case paging = "paging"
        case sort = "sort"
        case availableSorts = "available_sorts"
        case results = "results"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        siteId = try values.decodeIfPresent(String.self, forKey: .siteId)
        countryDefaultTimeZone = try values.decodeIfPresent(String.self, forKey: .countryDefaultTimeZone)
        query = try values.decodeIfPresent(String.self, forKey: .query)
        paging = try values.decodeIfPresent(Paging.self, forKey: .paging)
        sort = try values.decodeIfPresent(Sort.self, forKey: .sort)
        availableSorts = try values.decodeIfPresent([Sort].self, forKey: .availableSorts)
        results = try values.decodeIfPresent([Product].self, forKey: .results) ?? []
    }

}

public struct Product : Codable, Hashable {
    
    let id : String?
    let title : String
    let condition : String
    let thumbnail_id : String?
    let catalogProductId : String?
    let listingTypeId : String?
    let permalink : String?
    let buyingMode : String?
    let siteId : String?
    let categoryId : String?
    let domainId : String?
    let thumbnail : String?
    let currencyId : String?
    let orderBackend : Int?
    let price : Double
    let originalPrice : Double
    let salePrice : String?
    let availableQuantity : Int?
    let officialStoreId : Int?
    let officialStoreName: String?
    let useThumbnailId : Bool?
    let acceptsMercadopago : Bool?
    let stopTime : String?
    let installments : Installments?
    let winnerItemId : String?
    let catalogListing : Bool?
    let discounts : String?
    let promotions : [String]?
    let inventoryId : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case condition = "condition"
        case thumbnail_id = "thumbnail_id"
        case catalogProductId = "catalog_product_id"
        case listingTypeId = "listing_type_id"
        case permalink = "permalink"
        case buyingMode = "buying_mode"
        case siteId = "site_id"
        case categoryId = "category_id"
        case domainId = "domain_id"
        case thumbnail = "thumbnail"
        case currencyId = "currency_id"
        case orderBackend = "order_backend"
        case price = "price"
        case originalPrice = "original_price"
        case salePrice = "sale_price"
        case availableQuantity = "available_quantity"
        case officialStoreId = "official_store_id"
        case officialStoreName = "official_store_name"
        case useThumbnailId = "use_thumbnail_id"
        case acceptsMercadopago = "accepts_mercadopago"
        case stopTime = "stop_time"
        case installments = "installments"
        case winnerItemId = "winner_item_id"
        case catalogListing = "catalog_listing"
        case discounts = "discounts"
        case promotions = "promotions"
        case inventoryId = "inventory_id"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        condition = try values.decodeIfPresent(String.self, forKey: .condition) ?? ""
        thumbnail_id = try values.decodeIfPresent(String.self, forKey: .thumbnail_id)
        catalogProductId = try values.decodeIfPresent(String.self, forKey: .catalogProductId)
        listingTypeId = try values.decodeIfPresent(String.self, forKey: .listingTypeId)
        permalink = try values.decodeIfPresent(String.self, forKey: .permalink)
        buyingMode = try values.decodeIfPresent(String.self, forKey: .buyingMode)
        siteId = try values.decodeIfPresent(String.self, forKey: .siteId)
        categoryId = try values.decodeIfPresent(String.self, forKey: .categoryId)
        domainId = try values.decodeIfPresent(String.self, forKey: .domainId)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
        currencyId = try values.decodeIfPresent(String.self, forKey: .currencyId)
        orderBackend = try values.decodeIfPresent(Int.self, forKey: .orderBackend)
        price = try values.decodeIfPresent(Double.self, forKey: .price) ?? 0.0
        originalPrice = try values.decodeIfPresent(Double.self, forKey: .originalPrice) ?? 0.0
        salePrice = try values.decodeIfPresent(String.self, forKey: .salePrice)
        availableQuantity = try values.decodeIfPresent(Int.self, forKey: .availableQuantity)
        officialStoreId = try values.decodeIfPresent(Int.self, forKey: .officialStoreId)
        officialStoreName = try values.decodeIfPresent(String.self, forKey: .officialStoreName)
        useThumbnailId = try values.decodeIfPresent(Bool.self, forKey: .useThumbnailId)
        acceptsMercadopago = try values.decodeIfPresent(Bool.self, forKey: .acceptsMercadopago)
        stopTime = try values.decodeIfPresent(String.self, forKey: .stopTime)
        installments = try values.decodeIfPresent(Installments.self, forKey: .installments)
        winnerItemId = try values.decodeIfPresent(String.self, forKey: .winnerItemId)
        catalogListing = try values.decodeIfPresent(Bool.self, forKey: .catalogListing)
        discounts = try values.decodeIfPresent(String.self, forKey: .discounts)
        promotions = try values.decodeIfPresent([String].self, forKey: .promotions)
        inventoryId = try values.decodeIfPresent(String.self, forKey: .inventoryId)
    }

}
