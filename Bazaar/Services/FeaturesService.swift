//
//  FeaturesService.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/26/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import MOLH
import Alamofire
import SwiftyJSON

class FeaturesService {
    
    static let instance = FeaturesService()
    
    func getFeatures(completion: @escaping (_ error: Error?, _ allAds: [Feature]?) -> Void){
        Alamofire.request(FEATURES_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
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
                        feature.FeaturePrice = item["FeaturePrice"]?.double ?? 0.0
                        features.append(feature)
                    }
                }
                completion(nil,features)
            }
        }
    }
}

