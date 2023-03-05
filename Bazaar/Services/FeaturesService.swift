//
//  FeaturesService.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import MOLH
import Alamofire
import SwiftyJSON

class FeaturesService {
    
    static let instance = FeaturesService()
    
    func getFeatures(completion: @escaping (_ error: Error?, _ allAds: [Feature]?) -> Void){
        Alamofire.request(FEATURES_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER_BOTH).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, nil)
                print(error)
            case .success(let value):
                let json = JSON(value)
                var features = [Feature]()
                if let featuresArr = json.array {
                    for item in featuresArr {
                        guard let item = item.dictionary else {return}
                        let feature = Feature()
                        feature.FeatureId = item["FeatureId"]?.int ?? 0
                        feature.FeatureNameAR = item["FeatureNameAR"]?.string ?? ""
                        feature.FeatureNameEN = item["FeatureNameEN"]?.string ?? ""
                        feature.FeatureDescription = item["FeatureDescription"]?.string ?? ""
                        feature.FeatureDescriptionEN = item["FeatureDescriptionEN"]?.string ?? ""
                        feature.currencyAr = item["Currency"]?.string ?? ""
                        feature.currencyEn = item["CurrencyEN"]?.string ?? ""
                        
                        feature.FeaturePrice = item["FeaturePrice"]?.double ?? 0.0
                        features.append(feature)
                    }
                }
                completion(nil,features)
            }
        }
    }
    
    func getunSelectedFeaturesFeatures(id: Int,completion: @escaping (_ error: Error?, _ allAds: [Feature]?) -> Void){
        print(UNSELECTEDـFEATURES_URL + "\(id)")
        Alamofire.request(UNSELECTEDـFEATURES_URL + "\(id)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER_BOTH).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, nil)
                print(error)
            case .success(let value):
                print(value)
                let json = JSON(value)
                var features = [Feature]()
                if let add = json.dictionary {
                    if let featuresArr = add["UnSelectedFeature"]?.array {
                        for item in featuresArr {
                            guard let item = item.dictionary else {return}
                            let feature = Feature()
                            feature.FeatureId = item["FeatureId"]?.int ?? 0
                            feature.FeatureNameAR = item["FeatureNameAR"]?.string ?? ""
                            feature.FeatureNameEN = item["FeatureNameEN"]?.string ?? ""
                            feature.FeatureDescription = item["FeatureDescription"]?.string ?? ""
                            feature.FeatureDescriptionEN = item["FeatureDescriptionEN"]?.string ?? ""
                            feature.currencyAr = item["Currency"]?.string ?? ""
                            feature.currencyEn = item["CurrencyEN"]?.string ?? ""
                            
                            feature.FeaturePrice = item["FeaturePrice"]?.double ?? 0.0
                            features.append(feature)
                        }
                    }
                    completion(nil,features)
                    
                }
                
            }
        }
    }
}

