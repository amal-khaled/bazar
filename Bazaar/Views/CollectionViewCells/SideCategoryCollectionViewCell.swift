//
//  SideCategoryCollectionViewCell.swift
//  Bazaar
//
//  Created by Amal Elgalant on 12/03/2023.
//  Copyright © 2023 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH

class SideCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageBackView: UIView!
    
    @IBOutlet weak var cImageView: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var divider: UIView!
    
    override var isSelected: Bool {
        didSet {
            if !isSelected {
                // animate selection
                backgroundColor = .clear
                imageBackView.layer.borderColor = UIColor(named: "dark_color")?.cgColor
                lbl_name.textColor = .black
               divider.backgroundColor = .clear
            } else {
                backgroundColor =  UIColor(named: "main_color")
                lbl_name.textColor = .white

                imageBackView.layer.borderColor = UIColor.white.cgColor
                divider.backgroundColor = UIColor(named: "dark_color")
                //dark_color
                // animate deselection
            }
        }
    }
    func setData(category:Category) {
     
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            lbl_name.text = category.nameAr
            
        } else {
            lbl_name.text = category.nameEn
        }
        
        cImageView.sd_setImage(with: URL(string: category.imgUrl), placeholderImage: UIImage(named: "placeholder.png"))
    }
}
