//
//  StoreServices.swift
//  Bazaar
//
//  Created by Amal Elgalant on 14/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation

import Foundation
import Alamofire
import MOLH


class StoreServices {
    
    static let instance = StoreServices()
    
    func getAllProducts( page: Int,completion: @escaping ([Product]) -> Void){
     
        APIConnection.apiConnection.getConnection(completion: {
            data  in
            guard let data = data else { return }
            
            do {
                let productArray = try JSONDecoder().decode([Product].self, from: data)
                
              
                completion(productArray )
               
                
            } catch let jerror{
                print(jerror)
                
                
            }
            
        }, link: ALL_PRODUCTS + "\(page)")
           
    }
}
