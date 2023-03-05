//
//  Order.swift
//  Bazaar
//
//  Created by Amal Elgalant on 19/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
struct Order: Codable{
    var name: String?
    var email: String?
    var phone: String?
    var country: String?
    var city: String?
    var area: String?
    var distinct: String?
    var street: String?
    var buildingNumber: String?
    var falt: String?
    var note: String?
    var products: [Product]?
    var paid: Bool?
    var id: Int?
    var refNum: String?
    var totalPrice: Double?
    var subtotal: Double?
    var shippingFess: Double?
    var date: String?
    var quantity: Int?

    //CreatedDate
    //        OrderTransaction = "<null>";
    //        OrderTransactionId = "<null>";
    //        User = "<null>";
    //        UserId = "a62943df-fa81-41aa-a59d-2858c52a0fc9";
    //        UserName = "a@a.aa";
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case email = "Email"
        case phone = "PhoneNumber"
        case area = "Area"
        case distinct = "Block"
        case city = "City"
        case country = "Country"
        case buildingNumber = "HouseBuliding"
        case paid = "IsPayed"
        case note = "Notes"
        case falt = "Number"
        case id = "OrderId"
        case products = "OrderItems"
        case refNum = "OrderReferenceNumber"
        case totalPrice = "OrderTotal"
        case subtotal = "Total"
        case shippingFess = "Shipping"
        case street = "street"
        case date = "CreatedDate"
    }
    
    
}
