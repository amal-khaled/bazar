//
//  NetworkHelper.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/10/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkHelper: NSObject {
    
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
