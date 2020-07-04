//
//  PayCell.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
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
        radioBtn.setImage(UIImage(named: "unchecked_rectangle"), for: .normal)
    }
    
    @IBAction func radioBtnPressed(_ sender: Any) {
        btnPressed?()
    }
}
