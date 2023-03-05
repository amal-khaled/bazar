//
//  PackagesService.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import MOLH
import Alamofire
import SwiftyJSON

class PackagesService {
    
    static let instance = PackagesService()
    
    func getPackages(completion: @escaping (_ error: Error?, _ packages: [Package]?) -> Void){
        Alamofire.request(PACKAGES_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER_BOTH).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, nil)
                print(error)
            case .success(let value):
                let json = JSON(value)
                print(value)
                var packages = [Package]()
                if let packagesArr = json.array {
                    for item in packagesArr {
                        guard let item = item.dictionary else {return}
                        let package = Package()
                        package.PackageId = item["PackageId"]?.int ?? 0
                        package.PackageName = item["PackageName"]?.string ?? ""
                        package.PackagePrice = item["PackagePrice"]?.double ?? 0.0
                        packages.append(package)
                    }
                }
                completion(nil,packages)
            }
        }
    }
}

