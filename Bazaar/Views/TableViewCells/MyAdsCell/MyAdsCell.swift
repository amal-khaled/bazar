//
//  MyAdsCell.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/9/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class MyAdsCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var adImg: UIImageView!
    @IBOutlet weak var adName: UILabel!
    @IBOutlet weak var adPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        adImg.addCornerRadius(cornerRadius: 20)
    }
}
