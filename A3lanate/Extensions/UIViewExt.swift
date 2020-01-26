//
//  UIViewExt.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 1/23/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation

import UIKit

extension UIView {
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 2.0, height: 2.0),
                   shadowOpacity: Float = 1,
                   shadowRadius: CGFloat = 4.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
    func addBorder(borderWidth: CGFloat = 1, borderColor: CGColor = #colorLiteral(red: 0, green: 0.5594217181, blue: 0.3978024721, alpha: 1)) {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor
    }
    
    func removeBorder(borderWidth: CGFloat = 0, borderColor: CGColor = UIColor.white.cgColor) {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor
    }
    
    func addCornerRadius(cornerRadius: CGFloat) {
        self.clipsToBounds = true
        layer.cornerRadius = cornerRadius
    }
    
//    func addShadowWithCorner(cornerRadius: CGFloat, shadowColor: CGColor, shadowOpacity: Float, shadowOffset: CGSize, shadowRadius: CGFloat) {
//        layer.cornerRadius = cornerRadius
//        layer.shadowColor = shadowColor
//        layer.shadowOpacity = shadowOpacity
//        layer.shadowOffset = shadowOffset
//        layer.shadowRadius = shadowRadius
//        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//        layer.shouldRasterize = true
//        layer.rasterizationScale = UIScreen.main.scale
//    }
}
