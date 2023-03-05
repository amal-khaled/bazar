//
//  StorePaymentMethods.swift
//  Bazaar
//
//  Created by Amal Elgalant on 21/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation

struct StorePaymentArray : Codable{
    
    var PaymentMethods: [StorePaymentMethod]?
    
    enum CodingKeys: String, CodingKey {
        case PaymentMethods = "PaymentMethods"
    }
}


struct StorePaymentMethod: Codable {
    var PaymentMethodId: Int = 0
    var PaymentMethodAr: String = ""
    var PaymentMethodEn: String = ""
    var IsDirectPayment: Bool = false
    var ServiceCharge: Double = 0.0
    var TotalAmount: Double = 0.0
    var CurrencyIso: String = ""
    var ImageUrl: String = ""
    
    enum CodingKeys: String, CodingKey {
        case PaymentMethodId
        case PaymentMethodAr
        case PaymentMethodEn
        case IsDirectPayment
        case ServiceCharge
        case TotalAmount
        case CurrencyIso
        case ImageUrl
    }
    
    
}

