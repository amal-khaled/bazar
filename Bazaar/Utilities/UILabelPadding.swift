//
//  UILabelPadding.swift
//  Bazaar
//
//  Created by iOSayed on 08/03/2023.
//  Copyright © 2023 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import UIKit

class UILabelPadding:UILabel {
    let padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
       override func drawText(in rect: CGRect) {
           super.drawText(in: rect.inset(by: padding))
       }

       override var intrinsicContentSize : CGSize {
           let superContentSize = super.intrinsicContentSize
           let width = superContentSize.width + padding.left + padding.right
           let heigth = superContentSize.height + padding.top + padding.bottom
           return CGSize(width: width, height: heigth)
       }
}
