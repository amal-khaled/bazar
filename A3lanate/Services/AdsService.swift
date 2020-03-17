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
    
    func getAdById(id: Int,completion: @escaping (_ error: Error?, _ ad: Ad?, _ images: [String]?, _ features: [Feature]?, _ userAds: [Ad]?, _ similarAds: [Ad]?) -> Void){
        Alamofire.request("\(AD_DETAIL_BY_ID_URL)\(id)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, nil, nil, nil, nil, nil)
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
                    ad.Featured = add["Featured"]?.bool ?? false
                    var images = [String]()
                    if let imagesArr = add["FileBanks"]?.array {
                        for item in imagesArr {
                            guard let item = item.dictionary else {return}
                            let image = item["FileURL"]?.string ?? ""
                            images.append(image)
                        }
                    }
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
                            similarAds.append(ad)
                        }
                    }
                    completion(nil,ad,images,features,userAds,similarAds)
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
                        all.append(ad)
                    }
                }
                completion(nil,all)
            }
        }
    }
    
    
}
