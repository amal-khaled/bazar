//
//  StoreService.swift
//  Bazaar
//
//  Created by Amal Elgalant on 14/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import Alamofire
import MOLH


class StoreService {
    
    static let instance = StoreService()
    
    func getAllProducts(completion: @escaping ([Product]) -> Void){
     
        APIConnection.apiConnection.getConnection(completion: {
            data  in
            guard let data = data else { return }
            
            do {
                let productArray = try JSONDecoder().decode(ProductArray.self, from: data)
                
              
                completion(productArray.Products ?? [Product]())
               
                
            } catch {
                print(error.localizedDescription)
                
                
            }
            
        }, link: ALL_PRODUCTS)
           
    }
}
