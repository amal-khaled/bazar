//
//  CountryCell.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var countryBtn: UIButton!
    
    //Variables
    var btnPressed: (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func countryBtnPressed(_ sender: Any) {
        btnPressed?()
    }
}
