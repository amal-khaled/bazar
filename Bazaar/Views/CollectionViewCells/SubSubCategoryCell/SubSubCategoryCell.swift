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
    
    @IBOutlet weak var bg: UIImageView!
    override var isSelected: Bool {
        didSet {
            if isSelected {
                // animate selection
                bg.image = UIImage(named: "Group 71650")
                subcategoryLbl.textColor = .white
            } else {
                bg.image = UIImage(named: "Rectangle 18926")
                subcategoryLbl.textColor = .black

            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func setupView() {
        mainView.addCornerRadius(cornerRadius: 30)
    }
}
