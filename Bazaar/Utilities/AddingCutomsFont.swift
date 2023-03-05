//
//  AddingCutomsFont.swift
//  Bazaar
//
//  Created by Amal Elgalant on 22/10/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import UIKit

struct AppFontName {
    static let medium = "Tajawal-Regular"
    static let regular = "Tajawal-Regular"
    static let Bold = "Tajawal-Bold"
    static let SemiBold = "Tajawal-Bold"
    
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {
    static var isOverrided: Bool = false
    
    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.SemiBold, size: size)!
    }
    
    @objc class func mySemiBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.SemiBold, size: size)!
    }
    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.Bold, size: size)!
    }
    @objc class func mediumSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.medium, size: size)!
    }
    
    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
                self.init(myCoder: aDecoder)
                return
        }
        var fontName = ""
        switch fontAttribute {
        case "CTFontRegularUsage":
            fontName = AppFontName.regular
        case  "CTFontSemiboldUsage","CTFontHeavyUsage", "CTFontBlackUsage":
            fontName = AppFontName.SemiBold
        case "CTFontMediumUsage":
            fontName = AppFontName.medium
        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
            fontName = AppFontName.Bold
        default:
            fontName = AppFontName.regular
        }
        self.init(name: fontName, size: fontDescriptor.pointSize)!
    }
    
    class func overrideInitialize() {
        guard self == UIFont.self, !isOverrided else { return }
        
        // Avoid method swizzling run twice and revert to original initialize function
        isOverrided = true
        
        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }
        
        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(mySemiBoldSystemFont(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
        }
        
        if let mediumSystemFontMethod = class_getClassMethod(self, #selector(mediumSystemFont(ofSize:))),
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(mediumSystemFont(ofSize:))) {
            method_exchangeImplementations(mediumSystemFontMethod, myItalicSystemFontMethod)
        }
        
        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}
