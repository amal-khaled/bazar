//
//  RegisterVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH
import NVActivityIndicatorView

class RegisterVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var exitBtn: UIButton!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var passTxtField: UITextField!
    @IBOutlet weak var confirmPassView: UIView!
    @IBOutlet weak var confirmPassTxtField: UITextField!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passwordEyeBtn: UIButton!
    @IBOutlet weak var confirmPassEyeBtn: UIButton!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    @IBOutlet weak var termsBtn: UIButton!
    
    //Variable
    var passeyeClick = true
    var confpasseyeClick = true
    var termsChecked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.isHidden = true
        setupView()
    }
    
    func setupView() {
        emailView.addCornerRadius(cornerRadius: 45)
        emailView.addBorder(borderWidth: 1, borderColor: #colorLiteral(red: 0.932130754, green: 0.6688258052, blue: 0, alpha: 1))
        confirmPassView.addCornerRadius(cornerRadius: 45)
        confirmPassView.addBorder(borderWidth: 1, borderColor: #colorLiteral(red: 0.932130754, green: 0.6688258052, blue: 0, alpha: 1))
        phoneView.addBorder(borderWidth: 1, borderColor: #colorLiteral(red: 0.932130754, green: 0.6688258052, blue: 0, alpha: 1))
        passView.addBorder(borderWidth: 1, borderColor: #colorLiteral(red: 0.932130754, green: 0.6688258052, blue: 0, alpha: 1))
        phoneBtn.addCornerRadius(cornerRadius: 35)
        loginView.addCornerRadius(cornerRadius: 40)
        loginView.addBorder(borderWidth: 1, borderColor: UIColor.gray.cgColor)
        phoneBtn.isHidden = true
        emailTxtField.delegate = self
        phoneTxtField.delegate = self
        passTxtField.delegate = self
        confirmPassTxtField.delegate = self
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            emailView.layer.maskedCorners = [.layerMinXMinYCorner]
            confirmPassView.layer.maskedCorners = [.layerMinXMaxYCorner]
            loginView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
            emailTxtField.textAlignment = .right
            phoneTxtField.textAlignment = .right
            passTxtField.textAlignment = .right
            confirmPassTxtField.textAlignment = .right
        } else {
            emailView.layer.maskedCorners = [.layerMaxXMinYCorner]
            confirmPassView.layer.maskedCorners = [.layerMaxXMaxYCorner]
            loginView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
            emailTxtField.textAlignment = .left
            phoneTxtField.textAlignment = .left
            passTxtField.textAlignment = .left
            confirmPassTxtField.textAlignment = .left
        }
    }
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func phoneBtnPressed(_ sender: Any) {
    }
    @IBAction func passwordEyeBtnPressed(_ sender: Any) {
        if(passeyeClick == true) {
            passTxtField.isSecureTextEntry = false
        } else {
            passTxtField.isSecureTextEntry = true
        }
        passeyeClick = !passeyeClick
    }
    
    @IBAction func confirmPassEyeBtnPressed(_ sender: Any) {
        if(confpasseyeClick == true) {
            confirmPassTxtField.isSecureTextEntry = false
        } else {
            confirmPassTxtField.isSecureTextEntry = true
        }
        confpasseyeClick = !confpasseyeClick
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
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        guard let phoneNumber = phoneTxtField.text, phoneTxtField.text != "" else {return}
        guard let email = emailTxtField.text, emailTxtField.text != "" else {return}
        guard let password = passTxtField.text, passTxtField.text != "" else {return}
        guard let confirmpassword = confirmPassTxtField.text, confirmPassTxtField.text != "" else {return}
        if self.termsChecked == true {
            if phoneNumber.isPhoneNumber {
                self.indicator.isHidden = false
                self.indicator.startAnimating()
                AuthService.instance.registerUser(email: email, password: password, confirmpassword: confirmpassword, PhoneNumber: phoneNumber) { (success) in
                    if success {
                        self.phoneBtn.isHidden = false
                        if NetworkHelper.getMessage() == nil {
                            AuthService.instance.loginUser(username: email, password: password) { (success) in
                                if success {
                                }
                                self.indicator.stopAnimating()
                                self.indicator.isHidden = true
                            }
                        } else {
                            self.indicator.stopAnimating()
                            self.indicator.isHidden = true
                            NetworkHelper.removeMessage()
                            let alert = UIAlertController(title: "", message: "This number or the email is already registered".localized, preferredStyle: .alert)
                            self.present(alert, animated: true, completion: nil)
                            let when = DispatchTime.now() + 2
                            DispatchQueue.main.asyncAfter(deadline: when){
                                alert.dismiss(animated: true, completion: nil)
                            }
                        }

                    }
                }
            } else {
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                let alert = UIAlertController(title: "", message: "Please make sure you entered a correct phone number".localized, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                let when = DispatchTime.now() + 2
                DispatchQueue.main.asyncAfter(deadline: when){
                    alert.dismiss(animated: true, completion: nil)
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
}

extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

