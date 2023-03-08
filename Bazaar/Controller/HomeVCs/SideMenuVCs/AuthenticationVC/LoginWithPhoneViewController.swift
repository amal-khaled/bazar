//
//  LoginWithPhoneViewController.swift
//  Bazaar
//
//  Created by Amal Elgalant on 17/04/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH
import NVActivityIndicatorView

class LoginWithPhoneViewController: UIViewController {
    
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var codeTF: UITextField!
    
    @IBOutlet weak var phoneImage: UIImageView!
    
    @IBOutlet weak var phoneView: UIView!
     @IBOutlet weak var passwordView: UIView!
     @IBOutlet weak var passwordTxtField: UITextField!
     @IBOutlet weak var loginBtn: UIButton!
     @IBOutlet weak var forgotPassBtn: UIButton!
     @IBOutlet weak var registerView: UIView!
     @IBOutlet weak var registerBtn: UIButton!
     @IBOutlet weak var passwordEyeBtn: UIButton!
     @IBOutlet weak var indicator: NVActivityIndicatorView!
     
     //Variable
     var eyeClick = true
    var countryList = [country]()
    var selectedCountry = country()
     override func viewDidLoad() {
         super.viewDidLoad()
        getCountryList()

         indicator.isHidden = true
         setupView()

     }
     
     func setupView() {
        // phoneView.addCornerRadius(cornerRadius: 45)
         phoneView.addBorder(borderWidth: 0.6, borderColor: UIColor.gray.cgColor)
         passwordView.layer.cornerRadius = 10.0
         phoneView.layer.cornerRadius = 10.0
         passwordView.clipsToBounds = true
         passwordView.addBorder(borderWidth: 0.6, borderColor: UIColor.gray.cgColor)
       //  loginBtn.addCornerRadius(cornerRadius: 40)
     //    registerView.addCornerRadius(cornerRadius: 40)
         registerView.addBorder(borderWidth: 0.6, borderColor: UIColor.gray.cgColor)
         phoneTF.delegate = self
         codeTF.delegate = self
         passwordTxtField.delegate = self
         if MOLHLanguage.currentAppleLanguage() == "ar" {
//             phoneView.layer.maskedCorners = [.layerMinXMinYCorner]
//             passwordView.layer.maskedCorners = [.layerMinXMaxYCorner]
//             registerView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
             phoneTF.textAlignment = .right
             passwordTxtField.textAlignment = .right
         } else {
//             phoneView.layer.maskedCorners = [.layerMaxXMinYCorner]
//             passwordView.layer.maskedCorners = [.layerMaxXMaxYCorner]
//             registerView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
             phoneTF.textAlignment = .left
             passwordTxtField.textAlignment = .left
         }
     }
     @IBAction func loginBtnPressed(_ sender: Any) {
         guard let phone = phoneTF.text, phoneTF.text != "" && checkValidPhonNumber(Phone: "\(self.selectedCountry.code)\(phoneTF.text!)") else {
            
            StaticFunctions.createErrorAlert(msg: "enter valid phone number".localized, vc: self)
            return}
         guard let pass = passwordTxtField.text, passwordTxtField.text != "" else {return}
         indicator.isHidden = false
         indicator.startAnimating()
        AuthService.instance.loginUserWithPhone(phone: phone, password: pass, cityID: String(self.selectedCountry.id)) { (success) in
             if success {
                 if NetworkHelper.getToken() == nil {
                     self.indicator.stopAnimating()
                     self.indicator.isHidden = true
                     let alert = UIAlertController(title: "", message: "Please make sure that the phone and the password is correct".localized, preferredStyle: .alert)
                     self.present(alert, animated: true, completion: nil)
                     let when = DispatchTime.now() + 2
                     DispatchQueue.main.asyncAfter(deadline: when){
                         alert.dismiss(animated: true, completion: nil)
                     }
                 }

                 self.indicator.stopAnimating()

                 self.indicator.isHidden = true

             }
         }
     }
     
     @IBAction func forgotPassBtnPressed(_ sender: Any) {
     }
     
     @IBAction func registerBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "register", sender: self)

     }
     
     @IBAction func passwordEyeBtnPressed(_ sender: Any) {
         if(eyeClick == true) {
             passwordTxtField.isSecureTextEntry = false
         } else {
             passwordTxtField.isSecureTextEntry = true
         }

         eyeClick = !eyeClick
     }
     

 }

extension LoginWithPhoneViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if codeTF == textField {
            if countryList.count > 0{
                self.showCountryList()
            }else{
                self.getCountryList(show: true)
            }
            return false
        }else{
            return true
        }
    }
}
extension LoginWithPhoneViewController{
    func showCountryList(){
        let alertController = UIAlertController(title: "Choose country".localized, message: "", preferredStyle: .actionSheet)
        
        for item in countryList{
            let superbutton = UIAlertAction(title: MOLHLanguage.currentAppleLanguage() == "ar" ? item.nameAr : item.nameEn , style: .default, handler: { (action) in
                self.phoneImage.isHidden = true
                self.codeTF.text = item.code
                self.selectedCountry = item
            })
            
            alertController.addAction(superbutton)
        }
        let cancel = UIAlertAction(title: "Cancel".localized , style: .cancel, handler: { (action) in
            
            
        })
        alertController.addAction(cancel)
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view //to set the source of your alert
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
        }
        self.present(alertController, animated: true, completion: nil)
    }
    func getCountryList(show: Bool = false){

        UtilitiesService.instance.getCounties(completion: {
            check, countries in
            if check == 0 {
                self.countryList = countries
                if show{
                    self.showCountryList()
                }
            }else{
                self.showCountryList()

            }
        })
    }


}
