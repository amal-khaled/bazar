//
//  APIConnection.swift
//  WEASY
//
//  Created by Amal Elgalant on 10/29/19.
//  Copyright © 2019 Amal Elgalant. All rights reserved.
//

import Foundation
import Alamofire

class APIConnection{
    static var apiConnection = APIConnection()
    
    
    func getConnection (completion: @escaping(Data?)-> (), link : String){
        let HEADER = [
            "Authorization" : "bearer \(String(describing: NetworkHelper.getToken() ?? ""))",
            "Content-Type" : "application/json; charset=utf-8"
        ]
        print(HEADER)
        Alamofire.request(link, method: .get, headers: HEADER ).responseJSON { response in
            print("=============================================")
            print(link)
            print(response)
            print("=============================================")

            if let JSON = response.data {
                completion(JSON)
            }
                
            else {
                print(response.error)

                completion(nil)
            }
        }
    }
    func postConnection (completion: @escaping(Data?)-> (), link : String, param: Parameters ){
        
        print(param)
        print(link)
       
        let HEADER = [
            "Authorization" : "bearer \(String(describing: NetworkHelper.getToken() ?? ""))",
            "Content-Type" : "application/json; charset=utf-8"
        ]
        print(HEADER)
        Alamofire.request(link, method: .post, parameters: param, encoding: JSONEncoding.default, headers: HEADER).responseJSON { response in
            print(response)

            if let JSON = response.data {
                completion(JSON)
            }
                
            else {
                print(response.error)

                completion(nil)
            }
        }
    }
    
   
}
