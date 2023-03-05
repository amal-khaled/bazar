//
//  commericalCollectionViewCell.swift
//  A3lanate
//
//  Created by Amal Elgalant on 7/10/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class commericalCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var commImageView: UIImageView!
  
        func setData(image : String){
        commImageView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "placeholder.png"))
    
    }
   

   
}
