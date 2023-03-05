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
    var AdLikes: Int = 0
    
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
    var link: String = ""
    var cur: String = ""
    var curEn: String = ""
    var governrateAR: String = ""
    var governrateEN: String = ""
    var whatsAppNumber: String = ""
    var hasLink = false
    var isDefalut = true
    
    override init() {
        
    }
    init(details dictionary: [String:Any]?){
        guard let dictionary = dictionary else {return}
        id = dictionary["CommericalAdId"] as! Int
        titleAr = dictionary["Title"] as! String
        if let _titleEn = dictionary["TitleEN"] as? String{
            titleEn = _titleEn
        }
       
        PhoneNumber = dictionary["PhoneNumber"] as! String
        AdViews = dictionary["AdViews"] as! Int
        AdLikes = dictionary["AdLikes"] as! Int
        if let fileBank = dictionary["CommAdFileBanks"] as? NSArray{
            for i in 0..<fileBank.count{
                let fileBankObject = fileBank[i] as! NSDictionary
                imgArr.append (fileBankObject["FileURL"] as! String)
            }
        }
        if let _link = dictionary["Link"] as? String{
            link = _link
            
        }
        if let _cur = dictionary["Currency"] as? String{
            self.cur = _cur
            self.curEn = dictionary["CurrencyEN"] as! String
        }
        if let city = dictionary["Governerates"] as? NSDictionary{
            governrateEN = city["GovernerateEN"] as! String
            governrateAR = city["GovernerateAR"] as! String
            
        }else{
            governrateEN = ""
            governrateAR = ""
        }
    }
    init(oneDay dictionary: [String:Any]?){
        guard let dictionary = dictionary else {return}
        if let _image = dictionary["Image"] as? String{
            
            imgUrl = dictionary["Image"] as! String
        }else {
            imgUrl = dictionary["ImageUrl"] as! String
            
        }
        if let _hasLink =  dictionary["NavigateToLink"] as? Bool{
            
            hasLink = _hasLink
        }
        
        if let _link = dictionary["Link"] as? String{
            link = _link
        }
        
        if let _phoneNumber = dictionary["phoneNumber"] as? String{
            PhoneNumber = _phoneNumber
        }
        if let _whatsapp = dictionary["whatsNumber"] as? String{
            whatsAppNumber = _whatsapp
        }
        
        
    }
}
