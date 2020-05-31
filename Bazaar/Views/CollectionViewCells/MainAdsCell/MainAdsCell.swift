//
//  MainAdsCell.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
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
    @IBOutlet weak var likeBtn: UIButton!
    
    //Variables
    var btnPressed: (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        imgView.addCornerRadius(cornerRadius: 20)
        moreDetailsBtn.addCornerRadius(cornerRadius: 7)
    }
    
    @IBAction func moreDetailsBtnPressed(_ sender: Any) {
    }

    @IBAction func likeBtnPressed(_ sender: Any) {
        btnPressed?()
    }
}
