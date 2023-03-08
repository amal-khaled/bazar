//
//  MainAdsCell.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH
import FSPagerView

class MainAdsCell: FSPagerViewCell {
    
    //Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
   

    @IBOutlet weak var contentLbl: UILabel!


//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
    
    func setData(ad: Ad){
       imgView.sd_setImage(with: URL(string: ad.imgUrl), placeholderImage: UIImage(named: "placeholder.png"))
       
        if MOLHLanguage.currentAppleLanguage() == "ar" {
         titleLbl.text = ad.titleAr

         contentLbl.text = ad.governrateAR


        } else {
           titleLbl.text = ad.titleEn
            
          contentLbl.text = ad.governrateEN


        }
    }
    

}
