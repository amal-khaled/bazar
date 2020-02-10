//
//  LoginVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 1/29/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        emailView.addCornerRadius(cornerRadius: 45)
        emailView.layer.maskedCorners = [.layerMaxXMinYCorner]
        emailView.addBorder(borderWidth: 0.6, borderColor: UIColor.gray.cgColor)
        passwordView.addCornerRadius(cornerRadius: 45)
        passwordView.layer.maskedCorners = [.layerMaxXMaxYCorner]
        passwordView.addBorder(borderWidth: 0.6, borderColor: UIColor.gray.cgColor)
        loginBtn.addCornerRadius(cornerRadius: 40)
        registerView.addCornerRadius(cornerRadius: 40)
        registerView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
        registerView.addBorder(borderWidth: 0.6, borderColor: UIColor.gray.cgColor)
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toMain", sender: self)
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        guard let email = emailTxtField.text, emailTxtField.text != "" else {return}
        guard let pass = passwordTxtField.text, passwordTxtField.text != "" else {return}
        
        AuthService.instance.loginUser(username: email, password: pass) { (success) in
            if success {
                if NetworkHelper.getToken() == nil {
                    let alert = UIAlertController(title: "", message: "Please make sure that the email and the password is correct".localized, preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    let when = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: when){
                        alert.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @IBAction func forgotPassBtnPressed(_ sender: Any) {
    }
    
    @IBAction func registerBtnPressed(_ sender: Any) {
    }
}
