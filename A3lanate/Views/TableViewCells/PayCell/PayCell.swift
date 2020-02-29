//
//  PayCell.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/9/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class PayCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var radioBtn: UIButton!
    @IBOutlet weak var featureTitleLbl: UILabel!
    @IBOutlet weak var featureDescLbl: UILabel!
    @IBOutlet weak var featurePriceLbl: UILabel!
    @IBOutlet weak var currencyLbl: UILabel!
    
    //Variables
    var btnPressed: (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func radioBtnPressed(_ sender: Any) {
        btnPressed?()
    }
}
