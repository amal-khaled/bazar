//
//  LocalizedButton.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/24/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH

class LocalizedButton: UIButton {
    
    override func awakeFromNib() {
        flipedDirection()
    }
    
    func flipedDirection() {
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            self.imageView?.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
}
