//
//  CountryCell.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/5/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var countryBtn: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func countryBtnPressed(_ sender: Any) {
    }
}
