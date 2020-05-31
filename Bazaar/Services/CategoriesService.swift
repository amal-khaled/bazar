//
//  CategoriesService.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import MOLH
import Alamofire
import SwiftyJSON

class CategoriesService {
    
    static let instance = CategoriesService()
    
    func getAllCategoriesWithSubCategoriesAndSomeAds(completion: @escaping (_ error: Error?, _ allCategories: [Category]?) -> Void) {
        Alamofire.request(ALLCATEGORIES_SUB_ADS_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, nil)
                print(error)
            case .success(let value):
                let json = JSON(value)
                var all = [Category]()
                if let allArr = json.array {
                    for item in allArr {
                        guard let item = item.dictionary else {return}
                        let category = Category()
                        category.id = item["CategoryId"]?.int ?? 0
                        category.nameAr = item["CategoryNameAR"]?.string ?? ""
                        category.nameEn = item["CategoryNameEN"]?.string ?? ""
                        category.imgUrl = item["ImageBank"]?["ImageURL"].string ?? ""
                        var ads = [Ad]()
                        if let adArr = item["AdDTOs"]?.array {
                            for item in adArr {
                                guard let item = item.dictionary else {return}
                                let ad = Ad()
                                ad.id = item["AdId"]?.int ?? 0
                                ad.titleAr = item["Title"]?.string ?? ""
                                ad.titleEn = item["TitleEN"]?.string ?? ""
                                ad.price = item["AdPrice"]?.double ?? 0.0
                                ad.isLoved = item["IsLoved"]?.bool ?? false
                                var imgArr = [String]()
                                if item["FileBanks"]?.array?.count == 0 {
                                    imgArr.append("")
                                } else {
                                    if let fileBank = item["FileBanks"]?.array {
                                        for item in fileBank {
                                            guard let item = item.dictionary else {return}
                                            var img = String()
                                            img = item["FileURL"]?.string ?? ""
                                            imgArr.append(img)
                                        }
                                    }
                                }
                                ad.imgArr = imgArr
                                ads.append(ad)
                            }
                        }
                        category.Ads = ads
                        var subCategories = [SubCategory]()
                        if let subCategoriesArr = item["SubCategories"]?.array {
                            for item in subCategoriesArr {
                                guard let item = item.dictionary else {return}
                                let subCategory = SubCategory()
                                subCategory.id = item["SubCategoryId"]?.int ?? 0
                                subCategory.nameAr = item["SubCategoryNameAR"]?.string ?? ""
                                subCategory.nameEn = item["SubCategoryNameEN"]?.string ?? ""
                                subCategory.imgUrl = item["ImageBank"]?["ImageURL"].string ?? ""
                                subCategory.categoryId = item["CategoryId"]?.int ?? 0
                                subCategory.createAt = item["CreateAt"]?.string ?? ""
                                subCategory.order = item["Order"]?.int ?? 0
                                subCategory.pageUrl = item["PageUrl"]?.string ?? ""
                                subCategory.showOnMenu = item["ShowOnMenu"]?.bool ?? false
                                subCategories.append(subCategory)
                            }
                        }
                        category.subCategories = subCategories
                        all.append(category)
                    }
                }
                completion(nil,all)
            }
        }
        
    }
    
    func getSubCategoriesAndAdsById(id: Int,completion: @escaping (_ error: Error?, _ CategoryId: Int, _ CategoryNameAR: String, _ CategoryNameEN: String, _ SubCategories: [SubCategory]?, _ Ads: [Ad]?) -> Void) {
        Alamofire.request("\(SUB_SUBCATEGORY_ADS_BY_ID_URL)\(id)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, 0, "", "", nil, nil)
                print(error)
            case .success(let value):
                let json = JSON(value)
                let categoryId = json["SubCategoryId"].int ?? 0
                let categoryNameAr = json["SubCategoryNameAR"].string ?? ""
                let categoryNameEn = json["SubCategoryNameEN"].string ?? ""
                
                var subCategories = [SubCategory]()
                if let subCategoriesArr = json["SubSubCategories"].array {
                    for item in subCategoriesArr {
                        guard let item = item.dictionary else {return}
                        let subCategory = SubCategory()
                        subCategory.id = item["SubSubCategoryId"]?.int ?? 0
                        subCategory.nameAr = item["SubSubCategoryNameAR"]?.string ?? ""
                        subCategory.nameEn = item["SubSubCategoryNameEN"]?.string ?? ""
                        subCategories.append(subCategory)
                    }
                }
                
                var ads = [Ad]()
                if let adsArr = json["Ads"].array {
                    for item in adsArr {
                        guard let item = item.dictionary else {return}
                        let ad = Ad()
                        ad.id = item["AdId"]?.int ?? 0
                        ad.titleAr = item["Title"]?.string ?? ""
                        ad.titleEn = item["TitleEN"]?.string ?? ""
                        ad.imgUrl = item["FileBank"]?["FileURL"].string ?? ""
                        ad.price = item["AdPrice"]?.double ?? 0.0
                        ad.isLoved = item["IsLoved"]?.bool ?? false
                        ads.append(ad)
                    }
                }
                completion(nil,categoryId,categoryNameAr,categoryNameEn,subCategories,ads)
            }
        }
    }
    
    func getSubSubCategoriesAndAdsById(id: Int,completion: @escaping (_ error: Error?, _ CategoryId: Int, _ CategoryNameAR: String, _ CategoryNameEN: String, _ Ads: [Ad]?) -> Void) {
        Alamofire.request("\(SUBSUBCATEGORY_ADS_BY_ID_URL)\(id)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, 0, "", "", nil)
                print(error)
            case .success(let value):
                let json = JSON(value)
                let categoryId = json["SubSubCategoryId"].int ?? 0
                let categoryNameAr = json["SubSubCategoryNameAR"].string ?? ""
                let categoryNameEn = json["SubSubCategoryNameEN"].string ?? ""
    
                var ads = [Ad]()
                if let adsArr = json["Ads"].array {
                    for item in adsArr {
                        guard let item = item.dictionary else {return}
                        let ad = Ad()
                        ad.id = item["AdId"]?.int ?? 0
                        ad.titleAr = item["Title"]?.string ?? ""
                        ad.titleEn = item["TitleEN"]?.string ?? ""
                        ad.imgUrl = item["FileBank"]?["FileURL"].string ?? ""
                        ad.price = item["AdPrice"]?.double ?? 0.0
                        ad.isLoved = item["IsLoved"]?.bool ?? false
                        ads.append(ad)
                    }
                }
                completion(nil,categoryId,categoryNameAr,categoryNameEn,ads)
            }
        }
    }
    
    func getSubCategoriesById(id: Int,completion: @escaping (_ error: Error?, _ SubCategories: [SubCategory]?) -> Void) {
        Alamofire.request("\(CAT_SUBCATEGORY_ADS_BY_ID_URL)\(id)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, nil)
                print(error)
            case .success(let value):
                let json = JSON(value)
                var subCategories = [SubCategory]()
                if let subCategoriesArr = json["SubCategories"].array {
                    for item in subCategoriesArr {
                        guard let item = item.dictionary else {return}
                        let subCategory = SubCategory()
                        subCategory.id = item["SubCategoryId"]?.int ?? 0
                        subCategory.nameAr = item["SubCategoryNameAR"]?.string ?? ""
                        subCategory.nameEn = item["SubCategoryNameEN"]?.string ?? ""
                        subCategories.append(subCategory)
                    }
                }
                completion(nil,subCategories)
            }
        }
    }
    
    func getCategoriesSubAndAdsById(id: Int,completion: @escaping (_ error: Error?, _ CategoryId: Int, _ CategoryNameAR: String, _ CategoryNameEN: String, _ SubCategories: [SubCategory]?, _ Ads: [Ad]?) -> Void) {
        Alamofire.request("\(CAT_SUBCATEGORY_ADS_BY_ID_URL)\(id)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, 0, "", "", nil, nil)
                print(error)
            case .success(let value):
                let json = JSON(value)
                let categoryId = json["CategoryId"].int ?? 0
                let categoryNameAr = json["CategoryNameAR"].string ?? ""
                let categoryNameEn = json["CategoryNameEN"].string ?? ""
                
                var subCategories = [SubCategory]()
                if let subCategoriesArr = json["SubCategories"].array {
                    for item in subCategoriesArr {
                        guard let item = item.dictionary else {return}
                        let subCategory = SubCategory()
                        subCategory.id = item["SubCategoryId"]?.int ?? 0
                        subCategory.nameAr = item["SubCategoryNameAR"]?.string ?? ""
                        subCategory.nameEn = item["SubCategoryNameEN"]?.string ?? ""
                        subCategories.append(subCategory)
                    }
                }
                
                var ads = [Ad]()
                if let adsArr = json["Ads"].array {
                    for item in adsArr {
                        guard let item = item.dictionary else {return}
                        let ad = Ad()
                        ad.id = item["AdId"]?.int ?? 0
                        ad.titleAr = item["Title"]?.string ?? ""
                        ad.titleEn = item["TitleEN"]?.string ?? ""
                        ad.imgUrl = item["FileBank"]?["FileURL"].string ?? ""
                        ad.price = item["AdPrice"]?.double ?? 0.0
                        ad.isLoved = item["IsLoved"]?.bool ?? false
                        ads.append(ad)
                    }
                }
                completion(nil,categoryId,categoryNameAr,categoryNameEn,subCategories,ads)
            }
        }
    }
    
}
