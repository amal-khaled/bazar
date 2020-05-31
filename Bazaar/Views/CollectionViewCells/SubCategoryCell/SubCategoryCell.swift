//
//  SubCategoryCell.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class SubCategoryCell: UICollectionViewCell {
    
    //Outlets
    @IBOutlet weak var offerImg: UIImageView!
    @IBOutlet weak var likrBtn: UIButton!
    @IBOutlet weak var typeNameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var currencyLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        offerImg.addCornerRadius(cornerRadius: 15)
    }
    
    @IBAction func likeBtnPressed(_ sender: Any) {
    }
}
