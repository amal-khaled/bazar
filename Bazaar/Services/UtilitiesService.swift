//
//  UtilitiesService.swift
//  Bazaar
//
//  Created by Amal Elgalant on 02/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import MOLH
import Alamofire

class UtilitiesService {
    
    static let instance = UtilitiesService()
    
    func getOneDayAd(completion: @escaping (_ error: Error?, _ sliderAds: [Ad]) -> Void){
        Alamofire.request(ONE_DAY_AD_URL + "\(AppDelegate.cityId)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, [Ad]())
                print(error)
            case .success(let value):
                print(value)
//                let json = JSON(value)

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
    func getCounties(completion: @escaping (Int, [country]) -> Void){
        Alamofire.request(CITY_URL , method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(1, [country]())
                print(error)
            case .success(let value):
                print(value)

                var countries = [country]()
                if let countriesJson = value as? NSArray{
                    for item in countriesJson {
                       
//                        let oneDayAd = Ad(oneDay: item as! NSDictionary as! [String : Any])
                        let oneCountry = country(with: item as! NSDictionary as! [String : Any])
                        countries.append(oneCountry)

                        
                    }
                    completion(0, countries)
                }
                
            }
        }
    }
    func getGovernrate(completion: @escaping (Int, [Governerate]) -> Void, countryId: Int){
        
        APIConnection.apiConnection.getConnection(completion: {
            data  in
            guard let data = data else { return }
            
            do {
                let governerateArray = try JSONDecoder().decode([Governerate].self, from: data)
                
                
              
                completion(0,governerateArray )
               
                
            } catch let jerror{
                print(jerror)
                
                
            }
            
        }, link: GOVERNERATE + "\(countryId)")
    }
    func getArea(completion: @escaping (Int, [Area]) -> Void, goverId: Int){
        
        APIConnection.apiConnection.getConnection(completion: {
            data  in
            guard let data = data else { return }
            
            do {
                let areaArray = try JSONDecoder().decode([Area].self, from: data)
                
                
              
                completion(0,areaArray )
               
                
            } catch let jerror{
                print(jerror)
                
                
            }
            
        }, link: AREA + "\(goverId)")
    }
}
