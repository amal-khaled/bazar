//
//  NotificationService.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NotificationService {
    
    static let instance = NotificationService()
    
    func getNotifications(completion: @escaping (_ error: Error?, _ notifications: [NotificationN]?) -> Void){
        Alamofire.request(NOTIFICATION_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER_BOTH).responseJSON { (response) in
            print(response.result.value)
            switch response.result {
            case .failure(let error):
                completion(error, nil)
                print(error)
            case .success(let value):
                let json = JSON(value)
                var notifications = [NotificationN]()
                if let notificationsArr = json.array {
                    for item in notificationsArr {
                        guard let item = item.dictionary else {return}
                        let notification = NotificationN()
                        notification.NotificationsId = item["NotificationsId"]?.int ?? 0
                        notification.Title = item["Title"]?.string ?? ""
                        notification.TitleEN = item["TitleEN"]?.string ?? ""
                        notification.Body = item["Body"]?.string ?? ""
                        notification.BodyEN = item["BodyEN"]?.string ?? ""
                        notification.AdId = item["AdId"]?.int ?? 0
                        notification.CommericalAdId = item["CommericalAdId"]?.int ?? 0

                        notification.DeviceTaken = item["DeviceTaken"]?.string ?? ""
                        notification.Id = item["Id"]?.string ?? ""
                        notification.Date = item["Date"]?.string ?? ""
                        notification.type =  (item["Type"]?.int) ?? 3
                        

                        notifications.append(notification)
                    }
                }
                completion(nil,notifications)
            }
        }
    }
}
