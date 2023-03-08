//
//  UIViewControllerExtenstions.swift
//  WeasyVendor
//
//  Created by Amal Elgalant on 2/6/20.
//  Copyright © 2020 Amal Elgalant. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import PhoneNumberKit
extension UIViewController : NVActivityIndicatorViewable{
    
    //check email validation
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func setupView(name: String, editProfile: Bool = false, noBack: Bool = false){
        backUsingSWip()
        
        
        
        
        //
        //
        
       
        
        
        let titleBtn = UIBarButtonItem(title: name, style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItems = [titleBtn]
        if !noBack{
            let backBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-arrow"), style: .plain, target: self, action: #selector(back))
            navigationItem.leftBarButtonItems?.insert(backBtn, at: 0)
            
        }
        
        
        
     
    }
  
  
   
   
    @objc func back(){
        // move to menu
        //                self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    func backUsingSWip(){
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func clossKeyBoard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
   
   
    
    func checkValidPhonNumber(Phone:String  )->Bool{
        do {
            let phoneNumberKit = PhoneNumberKit()
            let phoneNumber = try phoneNumberKit.parse(Phone)
            
            return true
            
        }
        catch {
            return false
            
        }
    }
    
    
    
}
// Helper function inserted by Swift 4.2 migrator.
func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
/*
 let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
 imageView.contentMode = .ScaleAspectFit
 
 let image = UIImage(named: "googlePlus")
 imageView.image = image
 
 navigationItem.titleView = imageView
 */
extension UINavigationController {

    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }

}
