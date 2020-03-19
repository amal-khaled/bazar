//
//  RegisterVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/2/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        emailView.addCornerRadius(cornerRadius: 45)
        emailView.addBorder(borderWidth: 1, borderColor: #colorLiteral(red: 0, green: 0.5594217181, blue: 0.3978024721, alpha: 1))
        confirmPassView.addCornerRadius(cornerRadius: 45)
        confirmPassView.addBorder(borderWidth: 1, borderColor: #colorLiteral(red: 0, green: 0.5594217181, blue: 0.3978024721, alpha: 1))
        phoneView.addBorder(borderWidth: 1, borderColor: #colorLiteral(red: 0, green: 0.5594217181, blue: 0.3978024721, alpha: 1))
        passView.addBorder(borderWidth: 1, borderColor: #colorLiteral(red: 0, green: 0.5594217181, blue: 0.3978024721, alpha: 1))
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
        } else {
            emailView.layer.maskedCorners = [.layerMaxXMinYCorner]
            confirmPassView.layer.maskedCorners = [.layerMaxXMaxYCorner]
            loginView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
        }
    }
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func phoneBtnPressed(_ sender: Any) {
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        guard let phoneNumber = phoneTxtField.text, phoneTxtField.text != "" else {return}
        guard let email = emailTxtField.text, emailTxtField.text != "" else {return}
        guard let password = passTxtField.text, passTxtField.text != "" else {return}
        guard let confirmpassword = confirmPassTxtField.text, confirmPassTxtField.text != "" else {return}

        AuthService.instance.registerUser(email: email, password: password, confirmpassword: confirmpassword, PhoneNumber: phoneNumber) { (success) in
            if success {
                self.phoneBtn.isHidden = false
                AuthService.instance.loginUser(username: email, password: password) { (success) in
                    if success {
                        if NetworkHelper.getToken() == nil {
                            let alert = UIAlertController(title: "", message: "Please make sure that the user name and the password is correct".localized, preferredStyle: .alert)
                            self.present(alert, animated: true, completion: nil)
                            let when = DispatchTime.now() + 3
                            DispatchQueue.main.asyncAfter(deadline: when){
                                alert.dismiss(animated: true, completion: nil)
                            }
                        }

                    }
                }
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

