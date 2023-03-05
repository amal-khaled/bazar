//
//  storeCollectionViewCell.swift
//  Bazaar
//
//  Created by Amal Elgalant on 13/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import SDWebImage
import MOLH
class storeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var storeImageView: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
  
    func setData(product: Product){
        self.storeImageView.sd_setImage(with: URL(string:product.image?[0].url ?? ""), placeholderImage: #imageLiteral(resourceName: "learning"))
        self.priceLbl.text = String(product.price ?? 0.00) + " KD"
        if MOLHLanguage.currentAppleLanguage() == "ar"{
        self.descriptionLbl.text = product.name
        }else{
            self.descriptionLbl.text = product.nameEn

        }
    }
    @IBAction func cartBtnAction(_ sender: Any) {
        
    }
}
