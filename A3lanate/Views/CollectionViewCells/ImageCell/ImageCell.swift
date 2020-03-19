//
//  ImageCell.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/24/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    //Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var adImg: UIImageView!
    @IBOutlet weak var downloadBtn: UIButton!
    
    //Variables
    var btnPressed: (() -> ())?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        downloadBtn.backgroundColor = UIColor.white
        downloadBtn.addCornerRadius(cornerRadius: 20)
    }
    
    @IBAction func downloadBtnPressed(_ sender: Any) {
        btnPressed?()
    }
    

}
