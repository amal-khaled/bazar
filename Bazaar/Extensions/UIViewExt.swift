//
//  UIViewExt.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import UIKit
import MOLH

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
    
    
    func addBorder(borderWidth: CGFloat = 1, borderColor: CGColor = #colorLiteral(red: 0.932130754, green: 0.6688258052, blue: 0, alpha: 1)) {
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
    
    func addShadowWithCorner(cornerRadius: CGFloat, shadowColor: CGColor, shadowOpacity: Float, shadowOffset: CGSize, shadowRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.size.width, height: thickness); break
        }
        
        layer.addSublayer(border)
    }
    
}
extension UIViewController{
    func basicNavigation(storyName: String, segueId: String){
        
        let vc = UIStoryboard(name: storyName, bundle: nil).instantiateViewController(withIdentifier: segueId)
        self.navigationController?.pushViewController(vc, animated: true)
        //        self.present(vc, animated: true, completion: nil)
    }
    func basicPresentation(storyName: String, segueId: String){
        
        let vc = UIStoryboard(name: storyName, bundle: nil).instantiateViewController(withIdentifier: segueId)
        vc.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal

//        self.navigationController?.pushViewController(vc, animated: true)
                self.present(vc, animated: true, completion: nil)
    }
}
