//
//  CategoriesCell.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    
    //Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        titleLbl.addCornerRadius(cornerRadius: 15)
        bgView.addCornerRadius(cornerRadius: 15)
        bgImg.addCornerRadius(cornerRadius: 15)
    }
}
