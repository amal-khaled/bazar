//
//  NotificationCell.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/4/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var actionLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var notifImg: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        notifImg.addCornerRadius(cornerRadius: 28)
        actionLbl.isHidden = true
    }
}
