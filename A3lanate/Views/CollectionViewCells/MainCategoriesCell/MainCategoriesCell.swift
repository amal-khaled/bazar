//
//  MainCategoriesCell.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 1/25/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class MainCategoriesCell: UICollectionViewCell {
    
    //Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLbl.isHidden = true
    }

}
