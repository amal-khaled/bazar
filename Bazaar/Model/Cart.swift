//
//  Cart.swift
//  Bazaar
//
//  Created by Amal Elgalant on 18/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation

struct Cart: Codable{
    var products = [Product]()
    var price = 0.00
    
    func saveCart(){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "cart")
        }
    }
    func getCart()-> Cart{
        let defaults = UserDefaults.standard
        if let savedCart = defaults.object(forKey: "cart") as? Data {
            let decoder = JSONDecoder()
            if let loadedCart = try? decoder.decode(Cart.self, from: savedCart) {
                return loadedCart
                
            }
        }
        return Cart()

    }
    func removeCart(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "cart")
      

    }
}
