//
//  AdsService.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/14/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import MOLH
import Alamofire
import SwiftyJSON

class AdsService {
    
    static let instance = AdsService()
    
    func getAll(completion: @escaping (_ error: Error?, _ allAds: [Ad]?) -> Void){
        Alamofire.request(ADS_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, nil)
                print(error)
            case .success(let value):
                let json = JSON(value)
                var all = [Ad]()
                if let allArr = json.array {
                    for item in allArr {
                        guard let item = item.dictionary else {return}
                        let ad = Ad()
                        ad.id = item["AdId"]?.int ?? 0
                        ad.titleAr = item["Title"]?.string ?? ""
                        ad.titleEn = item["TitleEN"]?.string ?? ""
                        ad.imgUrl = item["FileBank"]?["FileURL"].string ?? ""
                        ad.price = item["AdPrice"]?.double ?? 0.0
                        ad.isLoved = item["IsLoved"]?.bool ?? false
                        all.append(ad)
                    }
                }
                completion(nil,all)
            }
        }
    }
}
