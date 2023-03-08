//
//  RegisterWithPhoneViewController.swift
//  Bazaar
//
//  Created by Amal Elgalant on 19/04/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH
import NVActivityIndicatorView
import FirebaseAuth
import iOSDropDown

class RegisterWithPhoneViewController: UIViewController {
   
    
    @IBOutlet weak var fullNameView: UIView!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    
    @IBOutlet weak var countryView: UIView!
   
    @IBOutlet weak var CountryDropDwon: DropDown!
    @IBOutlet weak var countryLabel: UILabel!
    
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var codeTF: UITextField!
    
    @IBOutlet weak var codeDropDown: DropDown!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var passTxtField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passwordEyeBtn: UIButton!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    @IBOutlet weak var termsBtn: UIButton!
    
    // DropDown
    
    
    @IBOutlet weak var regionDropDown: DropDown!
    
    @IBOutlet weak var cityDropDown: DropDown!
    
    //Variable
    var passeyeClick = true
    var confpasseyeClick = true
    var termsChecked = false
    
    var countryList = [country]()
    var selectedCountry = country()
    var veerificationId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        getCountryList()
        
        indicator.isHidden = true
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        codeDropDown.text = ""
        codeDropDown.optionArray = ["+20","+965"]
        codeDropDown.optionIds = [20,65]
//        phoneCodeDropDwon.optionImageArray = ["kuwaitFlag","kuwaitFlag"]

        codeDropDown.didSelect{(selectedText , index ,id) in
            print("Selected String: \(selectedText) \n index: \(index)")
            self.codeTF.text = "\(selectedText)"
        }
        CountryDropDwon.text = "choose Country"
        CountryDropDwon.optionArray = ["Option 1", "Option 2", "Option 3","Option 4", "Option 5","Option 6", "Option 7","Option 8", "Option 9"]
        CountryDropDwon.optionIds = [1,23,54,22]
        CountryDropDwon.optionImageArray = ["location","location","location","location"]

        CountryDropDwon.didSelect{(selectedText , index ,id) in
            print("Selected String: \(selectedText) \n index: \(index)")
            self.CountryDropDwon.text = "\(selectedText)"
        }
        regionDropDown.text = "Region"
        regionDropDown.optionArray = ["Option 1", "Option 2", "Option 3","Option 4", "Option 5","Option 6", "Option 7","Option 8", "Option 9"]
        regionDropDown.optionIds = [1,23,54,22]

        regionDropDown.didSelect{(selectedText , index ,id) in
            print("Selected String: \(selectedText) \n index: \(index)")
            self.regionDropDown.text = "\(selectedText)"
        }
        cityDropDown.text = "City"
        cityDropDown.optionArray = ["Option 1", "Option 2", "Option 3","Option 4", "Option 5","Option 6", "Option 7","Option 8", "Option 9", "Option 10","Option 11", "Option 12","Option 13", "Option 14"]
        cityDropDown.optionIds = [1,23,54,22]

        cityDropDown.didSelect{(selectedText , index ,id) in
            print("Selected String: \(selectedText) \n index: \(index)")
            self.cityDropDown.text = "\(selectedText)"
        }
        
       // phoneView.addCornerRadius(cornerRadius: 45)
        phoneView.addBorder(borderWidth: 1, borderColor:  #colorLiteral(red: 0.6431372549, green: 0.6431372549, blue: 0.6431372549, alpha: 1))
        emailView.addBorder(borderWidth: 1, borderColor: #colorLiteral(red: 0.6431372549, green: 0.6431372549, blue: 0.6431372549, alpha: 1))
        fullNameView.addBorder(borderWidth: 1, borderColor: #colorLiteral(red: 0.6431372549, green: 0.6431372549, blue: 0.6431372549, alpha: 1))
        countryView.addBorder(borderWidth: 1, borderColor: #colorLiteral(red: 0.6431372549, green: 0.6431372549, blue: 0.6431372549, alpha: 1))
       // passView.addCornerRadius(cornerRadius: 45)
        passView.addBorder(borderWidth: 1, borderColor: #colorLiteral(red: 0.6431372549, green: 0.6431372549, blue: 0.6431372549, alpha: 1))
       // phoneBtn.addCornerRadius(cornerRadius: 35)
        //        phoneBtn.isHidden = true
        phoneTxtField.delegate = self
        passTxtField.delegate = self
        if MOLHLanguage.currentAppleLanguage() == "ar" {
         //   phoneView.layer.maskedCorners = [.layerMinXMinYCorner]
         //   passView.layer.maskedCorners = [.layerMinXMaxYCorner]
            phoneTxtField.textAlignment = .right
            passTxtField.textAlignment = .right
        } else {
//            phoneView.layer.maskedCorners = [.layerMaxXMinYCorner]
//            passView.layer.maskedCorners = [.layerMaxXMaxYCorner]
//            loginView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
            phoneTxtField.textAlignment = .left
            passTxtField.textAlignment = .left
        }
    }
    
    
    
    @IBAction func phoneBtnPressed(_ sender: Any) {
        
        PhoneAuthProvider.provider()
            .verifyPhoneNumber("\(self.selectedCountry.code)\(phoneTxtField.text!)", uiDelegate: self) { verificationID, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                print(verificationID)
                
            }
        //
        //
        guard let phoneNumber = phoneTxtField.text, phoneTxtField.text != "" && checkValidPhonNumber(Phone: "\(self.selectedCountry.code)\(phoneTxtField.text!)") else {
            
            StaticFunctions.createErrorAlert(msg: "enter valid phone number".localized, vc: self)
            return}
        guard let password = passTxtField.text, passTxtField.text != "" else {return}
        if self.termsChecked == true {
            self.indicator.isHidden = false
            self.indicator.startAnimating()
            AuthService.instance.registerUserWithPhone(password: password, PhoneNumber: phoneNumber, cityID: self.selectedCountry.id) { (success, msg) in
                if success {
                    //                        self.phoneBtn.isHidden = false
                    //                        if NetworkHelper.getMessage() == nil {
                    ////                            AuthService.instance.loginUser(username: email, password: password) { (success) in
                    ////                                if success {
                    ////                                }
                    ////                                self.indicator.stopAnimating()
                    ////                                self.indicator.isHidden = true
                    ////                            }
                    //                        } else {
                    self.indicator.stopAnimating()
                    self.indicator.isHidden = true
                    NetworkHelper.removeMessage()
                    PhoneAuthProvider.provider()
                        .verifyPhoneNumber("\(self.selectedCountry.code)\(self.phoneTxtField.text!)", uiDelegate: self) { verificationID, error in
                            if let error = error {
                                print(error.localizedDescription)
                                return
                            }
                            
                            self.veerificationId = verificationID ?? ""
                            let alert = UIAlertController(title: "", message: "We will send you message Now . to confirm the code".localized, preferredStyle: .alert)
                            self.present(alert, animated: true, completion: nil)
                            let when = DispatchTime.now() + 2
                            DispatchQueue.main.asyncAfter(deadline: when){
                                //                        alert.dismiss(animated: true, completion:
                                //                                        nil)
                                //
                                //                    }
                                //                        }
                                
                                alert.dismiss(animated: true) {
                                    self.performSegue(withIdentifier: "confirm", sender: self)
                                }
                            }
                        }
                    
                    
                }else{
                    self.indicator.isHidden = true
                    NetworkHelper.removeMessage()
                    let alert = UIAlertController(title: "", message:msg, preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    let when = DispatchTime.now() + 2
                    DispatchQueue.main.asyncAfter(deadline: when){
                        alert.dismiss(animated: true, completion: nil)
                    }
                }
            }
            
        } else {
            let alert = UIAlertController(title: "", message: "You have to agree to our terms and conditions first".localized, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    @IBAction func passwordEyeBtnPressed(_ sender: Any) {
        if(passeyeClick == true) {
            passTxtField.isSecureTextEntry = false
        } else {
            passTxtField.isSecureTextEntry = true
        }
        passeyeClick = !passeyeClick
    }
    
    
    @IBAction func termsBtnPressed(_ sender: Any) {
        if termsChecked == false {
            self.termsChecked = true
            self.termsBtn.setBackgroundImage(UIImage(named: "checked_rectangle"), for: .normal)
        } else {
            self.termsChecked = false
            self.termsBtn.setBackgroundImage(UIImage(named: "unchecked_rectangle"), for: .normal)
        }
    }
    
    @IBAction func loginBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "confirm"{
            let dvc =  segue.destination as! ConfirmViewController
                        dvc.cityId = String(self.selectedCountry.id)
                        dvc.phone = phoneTxtField.text!
                        dvc.password = passTxtField.text!
            dvc.verificationId = veerificationId
            
        }
    }
    
    
}

extension RegisterWithPhoneViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if codeTF == textField {
//            if countryList.count > 0{
//                self.showCountryList()
//            }else{
//                self.getCountryList(show: true)
//            }
//            return false
//        }else{
//            return true
//        }
        return true
    }
}
extension RegisterWithPhoneViewController{
    func showCountryList(){
        let alertController = UIAlertController(title: "Choose country".localized, message: "", preferredStyle: .actionSheet)
        
        for item in countryList{
            let superbutton = UIAlertAction(title: MOLHLanguage.currentAppleLanguage() == "ar" ? item.nameAr : item.nameEn , style: .default, handler: { (action) in
//                self.codeTF.text = item.code
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
extension RegisterWithPhoneViewController : AuthUIDelegate{
    
}
