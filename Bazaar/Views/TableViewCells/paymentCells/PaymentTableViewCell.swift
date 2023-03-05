//
//  PaymentTableViewCell.swift
//  Bazaar
//
//  Created by Amal Elgalant on 21/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH
class PaymentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var pImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setData(payment: StorePaymentMethod){
        if MOLHLanguage.isArabic(){
            nameLbl.text = payment.PaymentMethodAr
        }
        else{
            nameLbl.text = payment.PaymentMethodEn
        }
        pImageView.sd_setImage(with: URL(string: payment.ImageUrl), placeholderImage: #imageLiteral(resourceName: "redo"))
    }
    
}
