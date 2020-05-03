//
//  AdCell.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/9/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class AdCell: UICollectionViewCell {
    
    //Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cellImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        containerView.addCornerRadius(cornerRadius: 20)
    }
}
