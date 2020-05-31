//
//  SubSubCategoryCell.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class SubSubCategoryCell: UICollectionViewCell {
    
    //Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var subcategoryLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func setupView() {
        mainView.addCornerRadius(cornerRadius: 30)
    }
}
