//
//  MyAdvsCell.swift
//  Bazaar
//
//  Created by iOSayed on 19/03/2023.
//  Copyright © 2023 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class MyAdvsCell: UITableViewCell {

    //IBOutlets
    
    @IBOutlet weak var forDonationView: UIView!
    @IBOutlet weak var adsImage: UIImageView!
    @IBOutlet weak var adsTitleLabel: UILabel!
    @IBOutlet weak var adsPriceLabel:UILabel!
    @IBOutlet weak var currencyLabel:UILabel!
    @IBOutlet weak var callBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
