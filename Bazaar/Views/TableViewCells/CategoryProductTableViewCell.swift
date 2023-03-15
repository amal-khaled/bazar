//
//  CategoryTableViewCell.swift
//  Bazaar
//
//  Created by Amal Elgalant on 14/03/2023.
//  Copyright © 2023 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH

class CategoryProductTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var adImageView: UIImageView!
    @IBOutlet weak var viewsLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setData(ad: Ad){
        
        adImageView.sd_setImage(with: URL(string: ad.imgUrl), placeholderImage: UIImage(named: "placeholder.png"))
        viewsLbl.text = "\(ad.AdViews)"
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            titleLbl.text = ad.titleAr
            
            countryLbl.text = ad.governrateAR
            
            
        } else {
            titleLbl.text = ad.titleEn
            
            countryLbl.text = ad.governrateEN
            
            
        }
    }
    
    
    @IBAction func shareBtnAction(_ sender: Any) {
    }
    @IBAction func likeBtnAction(_ sender: Any) {
    }
    @IBAction func callAction(_ sender: Any) {
    }
    @IBAction func locationActioon(_ sender: Any) {
    }
}
