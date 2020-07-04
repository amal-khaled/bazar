//
//  PaymentMethod.swift
//  Bazaar
//
//  Created by Mahmoud Elshakoushy on 6/24/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import UIKit

class PaymentMethod: NSObject {
    var PaymentMethodId: Int = 0
    var PaymentMethodAr: String = ""
    var PaymentMethodEn: String = ""
    var IsDirectPayment: Bool = false
    var ServiceCharge: Double = 0.0
    var TotalAmount: Double = 0.0
    var CurrencyIso: String = ""
    var ImageUrl: String = ""
}
