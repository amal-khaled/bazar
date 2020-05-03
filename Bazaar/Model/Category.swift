//
//  Category.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/14/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class Category: NSObject {
    var id: Int = 0
    var nameAr: String = ""
    var nameEn: String = ""
    var imgUrl: String = ""
    var Ads = [Ad]()
    var subCategories = [SubCategory]()
}
