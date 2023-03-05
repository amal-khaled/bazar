//
//  NotificationCell.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import WebKit
import MOLH
class NotificationCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var bodyWebview: UITextView!
    //    @IBOutlet weak var bodyLbl: UILabel!
    @IBOutlet weak var notiImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
   

   
}
