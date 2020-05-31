//
//  LocalizedView.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH

class LocalizedView: UIView {

    override func awakeFromNib() {
        flipedDirection()
    }
    
    func flipedDirection() {
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            self.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }

}
