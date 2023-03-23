//
//  MyAdsCell.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH

class MyAdsCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var adImg: UIImageView!
    @IBOutlet weak var adName: UILabel!
    @IBOutlet weak var adPrice: UILabel!
    @IBOutlet weak var adsLocation: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var adsTime: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        adImg.addCornerRadius(cornerRadius: 20)
        guard let editImage = UIImage(named: "editBtnIcon") else {return}
        guard let deleteImage = UIImage(named: "deleteBtnIcon") else {return}
        guard let shareImage = UIImage(named: "shareBtnIcon") else {return}
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            editBtn.rightIcon(image: editImage)
            deleteBtn.rightIcon(image: deleteImage)
            shareBtn.rightIcon(image: shareImage)
        }else{
            editBtn.leftIcon(image: editImage)
            deleteBtn.leftIcon(image: deleteImage)
            shareBtn.leftIcon(image: shareImage)
        }
        
    }
}
