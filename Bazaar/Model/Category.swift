//
//  Category.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class Category: NSObject {
    var id: Int = 0
    var nameAr: String = ""
    var nameEn: String = ""
    var imgUrl: String = ""
    var subCount: Int = 0

    var Ads = [Ad]()
    var subCategories = [SubCategory]()
}
