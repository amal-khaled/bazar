//
//  LoginVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 1/29/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH
import NVActivityIndicatorView

class LoginVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTxtField: UITextField!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.isHidden = true
        setupView()
    }
    
    func setupView() {
        emailView.addCornerRadius(cornerRadius: 45)
        emailView.addBorder(borderWidth: 0.6, borderColor: UIColor.gray.cgColor)
        passwordView.addCornerRadius(cornerRadius: 45)
        passwordView.addBorder(borderWidth: 0.6, borderColor: UIColor.gray.cgColor)
        loginBtn.addCornerRadius(cornerRadius: 40)
        registerView.addCornerRadius(cornerRadius: 40)
        registerView.addBorder(borderWidth: 0.6, borderColor: UIColor.gray.cgColor)
        emailTxtField.delegate = self
        passwordTxtField.delegate = self
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            emailView.layer.maskedCorners = [.layerMinXMinYCorner]
            passwordView.layer.maskedCorners = [.layerMinXMaxYCorner]
            registerView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        } else {
            emailView.layer.maskedCorners = [.layerMaxXMinYCorner]
            passwordView.layer.maskedCorners = [.layerMaxXMaxYCorner]
            registerView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toMain", sender: self)
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        guard let email = emailTxtField.text, emailTxtField.text != "" else {return}
        guard let pass = passwordTxtField.text, passwordTxtField.text != "" else {return}
        indicator.isHidden = false
        indicator.startAnimating()
        AuthService.instance.loginUser(username: email, password: pass) { (success) in
            if success {
                if NetworkHelper.getToken() == nil {
                    self.indicator.stopAnimating()
                    self.indicator.isHidden = true
                    let alert = UIAlertController(title: "", message: "Please make sure that the email and the password is correct".localized, preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    let when = DispatchTime.now() + 3
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

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
