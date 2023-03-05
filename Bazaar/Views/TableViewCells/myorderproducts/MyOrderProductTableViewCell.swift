//
//  MyOrderProductTableViewCell.swift
//  Bazaar
//
//  Created by Amal Elgalant on 22/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH
class MyOrderProductTableViewCell: UITableViewCell {

    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var pImageView: UIImageView!
    var product = Product()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
   
   
   
    func setData(product: Product){
        self.product = product
        quantityLbl.text = "quantity: ".localized + "\(product.quanityInsideCart ?? 0)"
        priceLbl.text = "\(product.price ?? 0.00)" + " DK".localized
        if MOLHLanguage.currentAppleLanguage() == "ar"{
            self.nameLbl.text = product.name
        }else{
            self.nameLbl.text = product.nameEn
        }
        pImageView.sd_setImage(with: URL(string: product.orderImage!), placeholderImage: #imageLiteral(resourceName: "learning"))
    }
    
}
