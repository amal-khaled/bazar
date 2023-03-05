//
//  CustomSliderAdCollectionViewCell.swift
//  Bazaar
//
//  Created by Amal Elgalant on 11/11/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import ImageSlideshow
class CustomSliderAdCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var adImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    func setData(ad: Ad){
       
        adImageView.sd_setImage(with: URL(string: ad.imgUrl), placeholderImage: #imageLiteral(resourceName: "learning"))
        
    }
   
    
}
