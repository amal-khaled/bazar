//
//  SubCategoryCollectionViewCell.swift
//  Bazaar
//
//  Created by Amal Elgalant on 12/03/2023.
//  Copyright © 2023 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH

class SubCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var img: UIImageView!

    func setData(category:SubCategory) {
      
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            lbl_name.text = category.nameAr
            
        } else {
            lbl_name.text = category.nameEn
        }
        
        img.sd_setImage(with: URL(string: category.imgUrl), placeholderImage: UIImage(named: "placeholder.png"))
    }
}
