//
//  MyAdvsCell.swift
//  Bazaar
//
//  Created by iOSayed on 19/03/2023.
//  Copyright © 2023 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH

class MyAdvsCell: UITableViewCell {

    //IBOutlets
    
    @IBOutlet weak var forDonationView: UIView!
    @IBOutlet weak var adsImage: UIImageView!
    @IBOutlet weak var adsTitleLabel: UILabel!
    @IBOutlet weak var adsPriceLabel:UILabel!
    @IBOutlet weak var currencyLabel:UILabel!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var chatBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    private func setup(){
        guard let callImage = UIImage(named: "callFilledIcon") , let chatImage = UIImage(named: "chatIcon") else {return}
        forDonationView.addCornerRadius(cornerRadius: 5)
       if MOLHLanguage.currentAppleLanguage() == "ar" {
           callBtn.rightIcon(image: callImage)
           chatBtn.rightIcon(image: chatImage)
        }else{
            callBtn.leftIcon(image: callImage)
            chatBtn.leftIcon(image: chatImage)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
