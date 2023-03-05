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
    func getComme(completion: @escaping (_ error: Error?, [Ad]) -> Void,catID : Int, page : Int = 1){
        let url = "\(COMMERICAL_ADS_URL)/\(catID)/\(page)/\(AppDelegate.cityId)"
        print(url)
        var ads = [Ad]()
        Alamofire.request(url, method: .get, parameters: nil , encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            print(response.result.value)
            switch response.result {
            
            case .failure(let error):
                completion(error, ads)
                print(error)
            case .success(let value):
                let json = JSON(value)
                if let topAdsArr = json.array {
                    
                    
                    for item in topAdsArr {
                        guard let item = item.dictionary else {return}
                        let ad = Ad()
                        ad.id = item["CommericalAdId"]?.int ?? 0
                        ad.titleAr = item["Title"]?.string ?? ""
                        ad.titleEn = item["TitleEN"]?.string ?? ""
                        ad.imgUrl = item["CommAdFileBank"]?["FileURL"].string ?? ""
                        ad.AdViews = item["AdViews"]?.int ?? 0
                        ad.AdLikes = item["AdLikes"]?.int ?? 0
                        if let _cur = item["Currency"]?.string{
                            ad.cur = _cur
                            ad.curEn = (item["CurrencyEN"]?.string) ?? ""
                        }
                        ads.append(ad)
                    }
                }
                
                completion(nil,ads)
            }
            
        }
        
    }
    func getHome(completion: @escaping (_ error: Error?, _ sliderAds: [SliderAd]?, _ categories: [Category]?, _ topAds: [Ad]?, _ mostViewdAds: [Ad]?, _ latestAds: [Ad]?) -> Void){
        Alamofire.request(HOME_PAGE_URL + "/\(AppDelegate.cityId)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, nil, nil, nil, nil, nil)
                print(error)
            case .success(let value):
                let json = JSON(value)
                print(value)
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
                        ad.governrateAR = item["GovernerateAR"]?.string ?? ""
                        ad.governrateEN = item["GovernerateEN"]?.string ?? ""
                        if let _cur = item["Currency"]?.string{
                            print(_cur)
                            ad.cur = _cur
                            ad.curEn = (item["CurrencyEN"]?.string) ?? ""
                        }
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
                        ad.governrateAR = item["GovernerateAR"]?.string ?? ""
                        ad.governrateEN = item["GovernerateEN"]?.string ?? ""
                        if let _cur = item["Currency"]?.string{
                            print(_cur)

                            ad.cur = _cur
                            ad.curEn = (item["CurrencyEN"]?.string) ?? ""
                        }
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
                        ad.governrateAR = item["GovernerateAR"]?.string ?? ""
                        ad.governrateEN = item["GovernerateEN"]?.string ?? ""
                        if let _cur = item["Currency"]?.string{
                            print(_cur)

                            ad.cur = _cur
                            ad.curEn = (item["CurrencyEN"]?.string) ?? ""
                        }
                        latestAds.append(ad)
                    }
                }
                completion(nil,sliderads,categories,topAds,mostViewdAds,latestAds)
            }
        }
    }
    func getOneDayAd(completion: @escaping (_ error: Error?, _ sliderAds: [Ad]) -> Void){
        Alamofire.request(ONE_DAY_AD_URL + "\(AppDelegate.cityId)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, [Ad]())
                print(error)
            case .success(let value):
                print(value)
                let json = JSON(value)

                var oneDayAds = [Ad]()
                if let oneDayAdArray = value as? NSArray{
                    for item in oneDayAdArray {
                       
                        let oneDayAd = Ad(oneDay: item as! NSDictionary as! [String : Any])
                        oneDayAds.append(oneDayAd)

                        
                    }
                    completion(nil, oneDayAds)
                }
                
            }
        }
    }
    
    //1&type=2
    func getbetweenSliderAds(type: Int, completion: @escaping (_ error: Error?, _ sliderAds: [Ad]) -> Void){
        Alamofire.request(SliderADS + "\(AppDelegate.cityId)&type=\(type)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, [Ad]())
                print(error)
            case .success(let value):
                print(value)
//                let json = JSON(value)

                var oneDayAds = [Ad]()
                if let data =  value as? NSDictionary{
                if let oneDayAdArray = data["data"] as? NSArray{
                    for item in oneDayAdArray {
                       
                        let oneDayAd = Ad(oneDay: item as! NSDictionary as! [String : Any])
                        oneDayAds.append(oneDayAd)

                        
                    }
                    completion(nil, oneDayAds)
                }
                }
                
            }
        }
    }
}
