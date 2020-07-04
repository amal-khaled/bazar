//
//  NetworkHelper.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkHelper: NSObject {
    
    class func saveEmail(email: String) {
        let def = UserDefaults.standard
        def.setValue(email, forKey: "email")
        def.synchronize()
    }
    
    class func getEmail() -> String! {
        let def = UserDefaults.standard
        return def.object(forKey: "email") as? String
    }
    
    class func removeEmail() {
        let def = UserDefaults.standard
        def.removeObject(forKey: "email")
    }
    
    class func saveMessage(message: String) {
        let def = UserDefaults.standard
        def.setValue(message, forKey: "message")
        def.synchronize()
    }
    
    class func getMessage() -> String! {
        let def = UserDefaults.standard
        return def.object(forKey: "message") as? String
    }
    
    class func removeMessage() {
        let def = UserDefaults.standard
        def.removeObject(forKey: "message")
    }
    
    class func saveToken(token: String) {
        let def = UserDefaults.standard
        def.setValue(token, forKey: "token")
        def.synchronize()
        restartApp()
    }
    
    class func getToken() -> String! {
        let def = UserDefaults.standard
        return def.object(forKey: "token") as? String
    }
    
    class func removeToken() {
        let def = UserDefaults.standard
        def.removeObject(forKey: "token")
        restartApp()
    }
    
    class func restartApp() {
        guard let window = UIApplication.shared.keyWindow else {return}
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var vc: UIViewController
        if getToken() == nil {
            vc = sb.instantiateInitialViewController()!
        } else {
            vc = sb.instantiateViewController(withIdentifier: "mainTabBar")
        }
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
}
