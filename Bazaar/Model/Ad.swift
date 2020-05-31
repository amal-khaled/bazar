//
//  Ad.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class Ad: NSObject {
    var id: Int = 0
    var titleAr: String = ""
    var titleEn: String = ""
    var isLoved: Bool = false
    var price: Double = 0.0
    var imgUrl: String = ""
    var imgArr = [String]()
    var CategoryNameAR: String = ""
    var CategoryNameEN: String = ""
    var SubCategoryNameAR: String = ""
    var SubCategoryNameEN: String = ""
    var SubSubCategoryNameAR: String = ""
    var SubSubCategoryNameEN: String = ""
    var Description: String = ""
    var DescriptionEN: String = ""
    var PhoneNumber: String = ""
    var Period: Int = 0
    var AdViews: Int = 0
    var StartDate: String = ""
    var CreatedByName: String = ""
    var CreatedByEmail: String = ""
    var CreatedByImageURL: String = ""
    var CityId: Int = 0
    var CityAR: String = ""
    var CityEN: String = ""
    var Features = [Feature]()
    var AdNumber: String = ""
    var ShareLink: String = ""
    var StatusId: Int = 0
    var AllowMessage: Bool = false
    var AllowCall: Bool = false
    var AdWithoutPhone: Bool = false
    var AutomaticRepublish: Bool = false
    var userAds = [Ad]()
    var similarAds = [Ad]()
    var Featured: Bool = false
}
