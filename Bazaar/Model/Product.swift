//
//  Product.swift
//  Bazaar
//
//  Created by Amal Elgalant on 13/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation



struct Product: Codable {
    var image: [ProductFileBanks]?
    var name: String?
    var nameEn: String?
    var price: Double?
    var id: Int?
    var description: String?
    var descriptionEn: String?
    var stock: Int?
    var quanityInsideCart: Int?
    var orderImage: String?

    enum CodingKeys: String, CodingKey {
        case image = "ProductFileBanks"
        case id = "ProductId"
        case name = "Name"
        case nameEn = "NameEN"
        case description = "Description"
        case descriptionEn = "DescriptionEN"
        case price = "Price"
        case stock = "Quantity"
        case quanityInsideCart = "quanityInsideCart"
case orderImage = "Image"

    }
}

struct ProductFileBanks: Codable {
    var id: Int?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "ProductFileBankId"
        case url = "FileURL"

    }
}

   
