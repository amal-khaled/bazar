//
//  AdsService.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import MOLH
import Alamofire
import SwiftyJSON

class AdsService {
    
    static let instance = AdsService()
    
    func getAll(completion: @escaping (_ error: Error?, _ allAds: [Ad]?) -> Void){
        Alamofire.request(ADS_URL + "/\(AppDelegate.cityId)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
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
                        ad.governrateAR = item["GovernerateAR"]?.string ?? ""
                        ad.governrateEN = item["GovernerateEN"]?.string ?? ""
                        if let _cur = item["Currency"]?.string{
                            ad.cur = _cur
                            ad.curEn = (item["CurrencyEN"]?.string) ?? ""
                        }
                        all.append(ad)
                    }
                }
                completion(nil,all)
            }
        }
    }
    func getLatestAds(page: Int = 1,completion: @escaping (_ error: Error?, _ allAds: [Ad]?) -> Void){
        Alamofire.request(Latest_ADS_URL+"/\(page)/\(AppDelegate.cityId)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
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
                        ad.isDefalut = item["DefautAd"]?.bool ?? true

                        ad.titleAr = item["Title"]?.string ?? ""
                        ad.titleEn = item["TitleEN"]?.string ?? ""
                        ad.imgUrl = item["FileBank"]?["FileURL"].string ?? ""
                        ad.price = item["AdPrice"]?.double ?? 0.0
                        ad.isLoved = item["IsLoved"]?.bool ?? false
                        ad.governrateAR = item["GovernerateAR"]?.string ?? ""
                        ad.governrateEN = item["GovernerateEN"]?.string ?? ""
                        if let _cur = item["Currency"]?.string{
                            ad.cur = _cur
                            ad.curEn = (item["CurrencyEN"]?.string) ?? ""
                        }
                        all.append(ad)
                    }
                }
                completion(nil,all)
            }
        }
    }
    func getmostViewedAds(page: Int = 1,completion: @escaping (_ error: Error?, _ allAds: [Ad]?) -> Void){
        Alamofire.request(MOST_VIEWED_ADS_URL+"/\(page)/\(AppDelegate.cityId)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
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
                        ad.isDefalut = item["DefautAd"]?.bool ?? true
                        ad.titleAr = item["Title"]?.string ?? ""
                        ad.titleEn = item["TitleEN"]?.string ?? ""
                        ad.imgUrl = item["FileBank"]?["FileURL"].string ?? ""
                        ad.price = item["AdPrice"]?.double ?? 0.0
                        ad.isLoved = item["IsLoved"]?.bool ?? false
                        ad.governrateAR = item["GovernerateAR"]?.string ?? ""
                        ad.governrateEN = item["GovernerateEN"]?.string ?? ""
                        if let _cur = item["Currency"]?.string{
                            ad.cur = _cur
                            ad.curEn = (item["CurrencyEN"]?.string) ?? ""
                        }
                        all.append(ad)
                    }
                }
                completion(nil,all)
            }
        }
    }
    func getTopAds(page: Int = 1,completion: @escaping (_ error: Error?, _ allAds: [Ad]?) -> Void){
        Alamofire.request(TOP_ADS_URL+"/\(page)/\(AppDelegate.cityId)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, nil)
                print(error)
            case .success(let value):
                print(value)
                let json = JSON(value)
                var all = [Ad]()
                if let allArr = json.array {
                    for item in allArr {
                        guard let item = item.dictionary else {return}
                        let ad = Ad()
                        ad.id = item["AdId"]?.int ?? 0
                        ad.isDefalut = item["DefautAd"]?.bool ?? true

                        ad.titleAr = item["Title"]?.string ?? ""
                        ad.titleEn = item["TitleEN"]?.string ?? ""
                        ad.imgUrl = item["FileBank"]?["FileURL"].string ?? ""
                        ad.price = item["AdPrice"]?.double ?? 0.0
                        ad.isLoved = item["IsLoved"]?.bool ?? false
                        ad.governrateAR = item["GovernerateAR"]?.string ?? ""
                        ad.governrateEN = item["GovernerateEN"]?.string ?? ""
                        if let _cur = item["Currency"]?.string{
                            ad.cur = _cur
                            ad.curEn = (item["CurrencyEN"]?.string) ?? ""
                        }
                        all.append(ad)
                    }
                }
                completion(nil,all)
            }
        }
    }
    
    func getAdById(id: Int,completion: @escaping (_ error: Error?, _ ad: Ad?, _ images: [String]?, _ imagesUpdate: [ImageUpdate]?, _ features: [Feature]?, _ userAds: [Ad]?, _ similarAds: [Ad]?) -> Void){
        Alamofire.request("\(AD_DETAIL_BY_ID_URL)\(id)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, nil,nil,  nil, nil, nil, nil)
                print(error)
            case .success(let value):
                let json = JSON(value)
                let ad = Ad()
                if let add = json.dictionary {
                    print(add)
                    ad.id = add["AdId"]?.int ?? 0
                    ad.CategoryNameAR = add["CategoryNameAR"]?.string ?? ""
                    ad.CategoryNameEN = add["CategoryNameEN"]?.string ?? ""
                    ad.SubCategoryNameAR = add["SubCategoryNameAR"]?.string ?? ""
                    ad.SubCategoryNameEN = add["SubCategoryNameEN"]?.string ?? ""
                    ad.SubSubCategoryNameAR = add["SubSubCategoryNameAR"]?.string ?? ""
                    ad.SubSubCategoryNameEN = add["SubSubCategoryNameEN"]?.string ?? ""
                    ad.titleAr = add["Title"]?.string ?? ""
                    ad.Description = add["Description"]?.string ?? ""
                    ad.titleEn = add["TitleEN"]?.string ?? ""
                    ad.DescriptionEN = add["DescriptionEN"]?.string ?? ""
                    ad.PhoneNumber = add["PhoneNumber"]?.string ?? ""
                    ad.Period = add["Period"]?.int ?? 0
                    ad.AdViews = add["AdViews"]?.int ?? 0
                    ad.StartDate = add["StartDate"]?.string ?? ""
                    ad.CreatedByName = add["CreatedByName"]?.string ?? ""
                    ad.CreatedByEmail = add["CreatedByEmail"]?.string ?? ""
                    ad.CreatedByImageURL = add["CreatedByImageURL"]?.string ?? ""
                    ad.isLoved = add["IsLoved"]?.bool ?? false
                    ad.price = add["AdPrice"]?.double ?? 0.0
                    ad.CityId = add["City"]?["CityId"].int ?? 0
                    ad.CityAR = add["City"]?["CityAR"].string ?? ""
                    ad.CityEN = add["City"]?["CityEN"].string ?? ""
                    ad.ShareLink = add["ShareLink"]?.string ?? ""
                    ad.StatusId = add["StatusId"]?.int ?? 0
                    ad.AllowMessage = add["AllowMessage"]?.bool ?? false
                    ad.AllowCall = add["AllowCall"]?.bool ?? false
                    ad.AdWithoutPhone = add["AdWithoutPhone"]?.bool ?? false
                    ad.AutomaticRepublish = add["AutomaticRepublish"]?.bool ?? false
                    ad.governrateAR = add["GovernerateAR"]?.string ?? ""
                    ad.governrateEN = add["GovernerateEN"]?.string ?? ""
                    ad.Featured = add["Featured"]?.bool ?? false
                    if let _cur = add["Currency"]?.string{
                                                ad.cur = _cur
                                                ad.curEn = (add["CurrencyEN"]?.string) ?? ""
                                            }
                    var images = [String]()
                    var imagesUpdate = [ImageUpdate]()

                    if let imagesArr = add["FileBanks"]?.array {
                        for item in imagesArr {
                            guard let item = item.dictionary else {return}
                            let image = item["FileURL"]?.string ?? ""
                            images.append(image)
                            imagesUpdate.append(ImageUpdate(image: UIImage(),imageString: image, isNew: false, id: item["FileBankId"]?.int ?? 0))

                        }
                        
                    }
                    
                    print(images)
                    print(imagesUpdate)

                    var features = [Feature]()
                    if let featuresArr = add["Features"]?.array {
                        for item in featuresArr {
                            guard let item = item.dictionary else {return}
                            let feature = Feature()
                            feature.FeatureId = item["FeatureId"]?.int ?? 0
                            feature.FeatureNameAR = item["FeatureNameAR"]?.string ?? ""
                            feature.FeatureNameEN = item["FeatureNameEN"]?.string ?? ""
                            feature.FeatureDescription = item["FeatureDescription"]?.string ?? ""
                            feature.FeatureDescriptionEN = item["FeatureDescriptionEN"]?.string ?? ""
                            feature.FeaturePrice = item["FeaturePrice"]?.double ?? 0.0
                            features.append(feature)
                        }
                    }
                    var userAds = [Ad]()
                    if let userAdsArr = add["UserAds"]?.array {
                        for item in userAdsArr {
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
                                ad.cur = _cur
                                ad.curEn = (item["CurrencyEN"]?.string) ?? ""
                            }
                            userAds.append(ad)
                        }
                    }
                    var similarAds = [Ad]()
                    if let similarAdsArr = add["SimilarAds"]?.array {
                        for item in similarAdsArr {
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
                                ad.cur = _cur
                                ad.curEn = (item["CurrencyEN"]?.string) ?? ""
                            }
                            similarAds.append(ad)
                        }
                    }
                    completion(nil,ad,images, imagesUpdate,features,userAds,similarAds)
                }
            }
        }
    }
    
    func getLovedAds(completion: @escaping (_ error: Error?, _ lovedAds: [Ad]?) -> Void){
        Alamofire.request(FAVORITE_ADS_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER_BOTH).responseJSON { (response) in
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
                        ad.Description = item["Description"]?.string ?? ""
                        ad.DescriptionEN = item["DescriptionEN"]?.string ?? ""
                        ad.governrateAR = item["GovernerateAR"]?.string ?? ""
                        ad.governrateEN = item["GovernerateEN"]?.string ?? ""
                        if let _cur = item["Currency"]?.string{
                            ad.cur = _cur
                            ad.curEn = (item["CurrencyEN"]?.string) ?? ""
                        }
                        all.append(ad)
                    }
                }
                completion(nil,all)
            }
        }
    }
    
    func favoriteAdById(Id: Int, completion: @escaping CompletionHandler) {
        Alamofire.request("\(ADD_LOVE_BY_ID_URL)\(Id)", method: .post, parameters: nil, encoding: URLEncoding.default, headers: HEADER_BOTH).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func getOpenedAds(completion: @escaping (_ error: Error?, _ openedAds: [Ad]?) -> Void){
        Alamofire.request(OPENED_ADS_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER_BOTH).responseJSON { (response) in
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
                        ad.StatusId = item["StatusId"]?.int ?? 0
                        ad.governrateAR = item["GovernerateAR"]?.string ?? ""
                        ad.governrateEN = item["GovernerateEN"]?.string ?? ""
                        if let _cur = item["Currency"]?.string{
                            ad.cur = _cur
                            ad.curEn = (item["CurrencyEN"]?.string) ?? ""
                        }
                        all.append(ad)
                    }
                }
                completion(nil,all)
            }
        }
    }
    
    func getClosedAds(completion: @escaping (_ error: Error?, _ closdAds: [Ad]?) -> Void){
        Alamofire.request(CLOSED_ADS_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER_BOTH).responseJSON { (response) in
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
                        ad.StatusId = item["StatusId"]?.int ?? 0
                        ad.governrateAR = item["GovernerateAR"]?.string ?? ""
                        ad.governrateEN = item["GovernerateEN"]?.string ?? ""
                        if let _cur = item["Currency"]?.string{
                            ad.cur = _cur
                            ad.curEn = (item["CurrencyEN"]?.string) ?? ""
                        }
                        all.append(ad)
                    }
                }
                completion(nil,all)
            }
        }
    }
    
    func getUnpaidAds(completion: @escaping (_ error: Error?, _ unpaidAds: [Ad]?) -> Void){
        Alamofire.request(UNPAYED_ADS_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER_BOTH).responseJSON { (response) in
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
                        ad.StatusId = item["StatusId"]?.int ?? 0
                        ad.governrateAR = item["GovernerateAR"]?.string ?? ""
                        ad.governrateEN = item["GovernerateEN"]?.string ?? ""
                        if let _cur = item["Currency"]?.string{
                            ad.cur = _cur
                            ad.curEn = (item["CurrencyEN"]?.string) ?? ""
                        }
                        all.append(ad)
                    }
                }
                completion(nil,all)
            }
        }
    }
    
    func removeAdd(completion: @escaping (Bool) -> Void, adID: Int){
      
        print(REMOVE_AD + "\(adID)")
        Alamofire.request(REMOVE_AD + "\(adID)", method: .post, parameters: [:], encoding: URLEncoding.default, headers: HEADER_BOTH).responseJSON { (response) in
            print(response.result.value)
            switch response.result {
            case .failure(let error):
                print(error)
                completion(false)
                
            case .success(let value):
                
                completion(true)
                
            }
        }
    }
    func removeAddImage(completion: @escaping (Bool) -> Void, adID: Int){
      
        print(REMOVE_AD + "\(adID)")
        Alamofire.request(REMOVE_AD_IMAGE + "\(adID)", method: .post, parameters: [:], encoding: URLEncoding.default, headers: HEADER_BOTH).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(false)
                
            case .success(let value):
                
                completion(true)
                
            }
        }
    }
}
