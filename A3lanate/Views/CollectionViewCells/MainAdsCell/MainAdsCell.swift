//
//  MainAdsCell.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 1/25/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class MainAdsCell: UICollectionViewCell {
    
    //Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var moreDetailsBtn: UIButton!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    @IBAction func moreDetailsBtnPressed(_ sender: Any) {
    }
    
    func setupView() {
        imgView.addCornerRadius(cornerRadius: 20)
        moreDetailsBtn.addCornerRadius(cornerRadius: 7)
    }
    
}
