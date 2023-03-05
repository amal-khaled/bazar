//
//  country.swift
//  Bazaar
//
//  Created by Amal Elgalant on 05/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
struct country{
    var nameAr = ""
    var nameEn = ""
    var currencyAr = ""
    var currencyEn = ""
    var id = 0
    var code = ""
    var phoneNumberCount = 0
    
    init(with dictionary: [String:Any]?){
        guard let dictionary = dictionary else {return}
        nameAr = dictionary["CityAR"] as! String
        nameEn = dictionary["CityEN"] as! String
        id = dictionary["CityId"] as! Int
        currencyAr = dictionary["Currency"] as! String
        currencyEn = dictionary["CurrencyEN"] as! String
        code = dictionary["Code"] as! String
        phoneNumberCount = dictionary["PhoneNumberNo"] as! Int

    }
    init(){
        
    }
    
}
