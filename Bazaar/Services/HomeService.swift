//
//  HomeService.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import MOLH
import Alamofire
import SwiftyJSON

class HomeService {
    
    static let instance = HomeService()
    
    func getHome(completion: @escaping (_ error: Error?, _ sliderAds: [SliderAd]?, _ categories: [Category]?, _ topAds: [Ad]?, _ mostViewdAds: [Ad]?, _ latestAds: [Ad]?) -> Void){
        Alamofire.request(HOME_PAGE_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, nil, nil, nil, nil, nil)
                print(error)
            case .success(let value):
                let json = JSON(value)
                var sliderads = [SliderAd]()
                if let sliderArr = json["SliderAds"].array {
                    for item in sliderArr {
                        guard let item = item.dictionary else {return}
                        let slider = SliderAd()
                        slider.adId = item["AdId"]?.int ?? 0
                        slider.imgUrl = item["FileBank"]?["FileURL"].string ?? ""
                        sliderads.append(slider)
                    }
                }
                var categories = [Category]()
                if let catrArr = json["Categories"].array {
                    for item in catrArr {
                        guard let item = item.dictionary else {return}
                        let cat = Category()
                        cat.id = item["CategoryId"]?.int ?? 0
                        cat.nameAr = item["CategoryNameAR"]?.string ?? ""
                        cat.nameEn = item["CategoryNameEN"]?.string ?? ""
                        cat.imgUrl = item["ImageBank"]?["ImageURL"].string ?? ""
                        categories.append(cat)
                    }
                }
                var topAds = [Ad]()
                if let topAdsArr = json["TopAds"].array {
                    for item in topAdsArr {
                        guard let item = item.dictionary else {return}
                        let ad = Ad()
                        ad.id = item["AdId"]?.int ?? 0
                        ad.titleAr = item["Title"]?.string ?? ""
                        ad.titleEn = item["TitleEN"]?.string ?? ""
                        ad.imgUrl = item["FileBank"]?["FileURL"].string ?? ""
                        ad.price = item["AdPrice"]?.double ?? 0.0
                        ad.isLoved = item["IsLoved"]?.bool ?? false
                        topAds.append(ad)
                    }
                }
                var mostViewdAds = [Ad]()
                if let mostViewArr = json["MostViewedAds"].array {
                    for item in mostViewArr {
                        guard let item = item.dictionary else {return}
                        let ad = Ad()
                        ad.id = item["AdId"]?.int ?? 0
                        ad.titleAr = item["Title"]?.string ?? ""
                        ad.titleEn = item["TitleEN"]?.string ?? ""
                        ad.imgUrl = item["FileBank"]?["FileURL"].string ?? ""
                        ad.price = item["AdPrice"]?.double ?? 0.0
                        ad.isLoved = item["IsLoved"]?.bool ?? false
                        mostViewdAds.append(ad)
                    }
                }
                var latestAds = [Ad]()
                if let latestArr = json["LatestAds"].array {
                    for item in latestArr {
                        guard let item = item.dictionary else {return}
                        let ad = Ad()
                        ad.id = item["AdId"]?.int ?? 0
                        ad.titleAr = item["Title"]?.string ?? ""
                        ad.titleEn = item["TitleEN"]?.string ?? ""
                        ad.imgUrl = item["FileBank"]?["FileURL"].string ?? ""
                        ad.price = item["AdPrice"]?.double ?? 0.0
                        ad.isLoved = item["IsLoved"]?.bool ?? false
                        latestAds.append(ad)
                    }
                }
                completion(nil,sliderads,categories,topAds,mostViewdAds,latestAds)
            }
        }
    }
}
