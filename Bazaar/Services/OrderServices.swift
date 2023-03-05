//
//  OrderServices.swift
//  Bazaar
//
//  Created by Amal Elgalant on 19/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import Alamofire
class OrderServices {
    
    static let instance = OrderServices()
    
    func saveOrder(completion: @escaping (Order) -> Void, order: Order){
        
        var param: Parameters = ["Name": order.name!,
                     "Email": order.email!,
                     "PhoneNumber": order.phone!,
                     "Country": order.country!,
                     "City": order.city!,
                     "Area": order.area!,
                     "street": order.street!,
                     "Block": order.distinct!,
                     "HouseBuliding": order.buildingNumber!,
                     "Number": order.falt!,
                     "Notes": order.note ?? ""]
        var productDic = [[String:Int]]()
        for product in order.products! {
            let dic = ["ProductId": product.id ?? 0, "Quantity": product.quanityInsideCart ?? 0]
            productDic.append(dic)
        }
        param["OrderItems"] = productDic
        
        print(param)
        
        APIConnection.apiConnection.postConnection(completion: {
            data  in
            guard let data = data else { return }
            
            do {
                let orderObject = try JSONDecoder().decode(Order.self, from: data)


                completion(orderObject )
               
                
            } catch let jerror{
                print(jerror)
                
                
            }
            
        }, link: SEND_ORDER, param: param)
        
    }
    func getPaymentList(completion: @escaping ([StorePaymentMethod]) -> Void, orderId: Int){
        
     
        
        APIConnection.apiConnection.postConnection(completion: {
            data  in
            guard let data = data else { return }
            
            do {
                let paymentMethods = try JSONDecoder().decode(StorePaymentArray.self, from: data)


                completion(paymentMethods.PaymentMethods ?? [StorePaymentMethod]())
               
                
            } catch let jerror{
                print(jerror)
                
                
            }
            
        }, link: PAYMENT_LIST + "\(orderId)", param: [:])
        
    }
    func getMyOrders(completion: @escaping ([Order]) -> Void){
        
        APIConnection.apiConnection.getConnection(completion: {
            data  in
            guard let data = data else { return }
            
            do {
                let orderObject = try JSONDecoder().decode([Order].self, from: data)


                completion(orderObject )
               
                
            } catch let jerror{
                print(jerror)
                
                
            }
            
        }, link: MY_ORDERS)
        
    }
    func cencelOrder(completion: @escaping (Bool) -> Void, orderId: Int){
        
        APIConnection.apiConnection.postConnection(completion: {
            data  in
            guard let data = data else { return }
            
            do {
              

                completion(true )
               
                
            } catch let jerror{
                print(jerror)
                
                
            }
            
        }, link: CANCEL_ORDERS + "\(orderId)", param: [:])
        
    }
}
