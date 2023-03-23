//
//  UIViewControllerExt.swift
//  Bazaar
//
//  Created by iOSayed on 18/03/2023.
//  Copyright © 2023 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    // custom func for present View Controller as Navigation Controller
       func presentDetail(_ viewControllerTopresent : UIViewController){
           let transition = CATransition()
           transition.duration = 0.3
           transition.type = CATransitionType.push
           transition.subtype = CATransitionSubtype.fromRight
           transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
           self.view.window?.layer.add(transition, forKey: kCATransition)
           present(viewControllerTopresent, animated: false, completion: nil)
       }
       
       func presentSecondaryDetail(_ viewControllerTopresent : UIViewController){
           let transition = CATransition()
           transition.duration = 0.3
           transition.type = CATransitionType.push
           transition.subtype = CATransitionSubtype.fromRight
           transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
           guard let presentsdViewController = presentedViewController else {return}
           presentsdViewController.dismiss(animated: false, completion: {
               self.view.window?.layer.add(transition, forKey: kCATransition)
               self.present(viewControllerTopresent, animated: false, completion: nil)
           })
           
           
       }
       
       // custom func for dismiss View Controller as Navigation Controller
       func dismissDetail(){
           let transition = CATransition()
           transition.duration = 0.3
           transition.type = CATransitionType.push
           transition.subtype = CATransitionSubtype.fromLeft
           transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
           self.view.window?.layer.add(transition, forKey: kCATransition)
           dismiss(animated: false, completion: nil)
       }
}
