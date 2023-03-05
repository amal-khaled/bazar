//
//  StaticFunctions.swift
//  Sla
//
//  Created by Amal Elgalant on 3/29/20.
//  Copyright © 2020 Amal Elgalant. All rights reserved.
//

import Foundation
import UIKit
import PhoneNumberKit

class StaticFunctions {
    
    
    
    
    static func setNavifationIcon(VC: UIViewController){
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Logo White"))
        imageView.contentMode = .scaleAspectFit
        VC.navigationItem.titleView = imageView
    }
    
    static func getCurrentDevice()-> String{
        // 1. request an UITraitCollection instance
        let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
        
        // 2. check the idiom
        switch (deviceIdiom) {
        
        case .pad:
            return "iPad"
        case .phone:
            return "iPhone"
        default:
            return "Unspecified"
        }
    }
    
    static func createErrorAlert(msg: String, vc: UIViewController){
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        vc.present(alert, animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                alert.dismiss(animated: true, completion: nil)
            })
        })
    }
    static func enableBtn(btn: UIButton, status check: Bool){
        if check{
            btn.alpha = 1
            btn.isEnabled = true
        }
        else {
            btn.alpha = 0.5
            btn.isEnabled = false
        }
        
    }
  
   
    
    static func seteErrorLblStatus(errorLbl:UILabel, status: Bool, msg: String  ){
        errorLbl.sizeToFit()
        errorLbl.text = msg
        errorLbl.isHidden = status
        
    }
    static func checkValidPhonNumber(Phone:String  )->Bool{
        do {
            let phoneNumberKit = PhoneNumberKit()
            let phoneNumber = try phoneNumberKit.parse(Phone)
            
            return true
            
        }
        catch {
            return false
            
        }
    }
    static func call(phone : String, vc: UIViewController){
        if phone.isEmpty{
            StaticFunctions.createErrorAlert(msg: "No phone number".localized, vc: vc)
            return
        }
        guard let number = URL(string: "tel://" + phone) else { return }
        UIApplication.shared.open(number)
    }
    static func register(viewController: UIViewController){
        //        viewController.basicNavigation(storyName: Auth_STORY_BOARD, segueId: REGISTER_VCID)
    }
  
   
    static func backTwo(viewController: UIViewController) {
        let viewControllers: [UIViewController] = viewController.navigationController!.viewControllers as [UIViewController]
        viewController.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    static func backThree(viewController: UIViewController) {
        let viewControllers: [UIViewController] = viewController.navigationController!.viewControllers as [UIViewController]
        viewController.navigationController!.popToViewController(viewControllers[viewControllers.count - 4], animated: true)
    }
    static func backNumber(viewController: UIViewController, number: Int = 2) {
        let viewControllers: [UIViewController] = viewController.navigationController!.viewControllers as [UIViewController]
        viewController.navigationController!.popToViewController(viewControllers[viewControllers.count - (number + 1)], animated: true)
    }
    
    
  
    
    
}
