//
//  PaymentMethodService.swift
//  Bazaar
//
//  Created by Mahmoud Elshakoushy on 6/24/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import MOLH

class PaymentMethodService {
    
    static let instance = PaymentMethodService()
    
    func getPaymentMethodsForAd(ad: Int,completion: @escaping (_ error: Error?, _ paymentMethods: [PaymentMethod]?) -> Void) {
        var parameters = [String: Any]()
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            parameters = [
                "AdId" : ad,
               "Lang": "ar",
               ]
        } else {
            parameters = [
                "AdId" : ad,
               "Lang": "en",
               ]
        }
        Alamofire.request(PAYMENTMETHODFORAD_URL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: HEADER_BOTH).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, nil)
                print(error)
            case .success(let value):
                let json = JSON(value)
                var paymentMethods = [PaymentMethod]()
                if let paymentMethodsArr = json["PaymentMethods"].array {
                    for item in paymentMethodsArr {
                        guard let item = item.dictionary else {return}
                        let paymentMethod = PaymentMethod()
                        paymentMethod.PaymentMethodId = item["PaymentMethodId"]?.int ?? 0
                        paymentMethod.PaymentMethodAr = item["PaymentMethodAr"]?.string ?? ""
                        paymentMethod.PaymentMethodEn = item["PaymentMethodEn"]?.string ?? ""
                        paymentMethod.ImageUrl = item["ImageUrl"]?.string ?? ""
                        paymentMethod.CurrencyIso = item["CurrencyIso"]?.string ?? ""
                        paymentMethod.IsDirectPayment = item["IsDirectPayment"]?.bool ?? false
                        paymentMethod.ServiceCharge = item["ServiceCharge"]?.double ?? 0.0
                        paymentMethod.TotalAmount = item["TotalAmount"]?.double ?? 0.0
                        paymentMethods.append(paymentMethod)
                    }
                }
                completion(nil,paymentMethods)
            }
        }
    }
    
    func getPaymentMethodsForPackage(package: Int,completion: @escaping (_ error: Error?, _ paymentMethods: [PaymentMethod]?) -> Void) {
        var parameters = [String: Any]()
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            parameters = [
                "PackageId" : package,
               "Lang": "ar",
               ]
        } else {
            parameters = [
                "PackageId" : package,
               "Lang": "en",
               ]
        }
        Alamofire.request(PAYMENTMETHODFORPACKAGE_URL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: HEADER_BOTH).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, nil)
                print(error)
            case .success(let value):
                let json = JSON(value)
                var paymentMethods = [PaymentMethod]()
                if let paymentMethodsArr = json["PaymentMethods"].array {
                    for item in paymentMethodsArr {
                        guard let item = item.dictionary else {return}
                        let paymentMethod = PaymentMethod()
                        paymentMethod.PaymentMethodId = item["PaymentMethodId"]?.int ?? 0
                        paymentMethod.PaymentMethodAr = item["PaymentMethodAr"]?.string ?? ""
                        paymentMethod.PaymentMethodEn = item["PaymentMethodEn"]?.string ?? ""
                        paymentMethod.ImageUrl = item["ImageUrl"]?.string ?? ""
                        paymentMethod.CurrencyIso = item["CurrencyIso"]?.string ?? ""
                        paymentMethod.IsDirectPayment = item["IsDirectPayment"]?.bool ?? false
                        paymentMethod.ServiceCharge = item["ServiceCharge"]?.double ?? 0.0
                        paymentMethod.TotalAmount = item["TotalAmount"]?.double ?? 0.0
                        paymentMethods.append(paymentMethod)
                    }
                }
                completion(nil,paymentMethods)
            }
        }
    }
}

