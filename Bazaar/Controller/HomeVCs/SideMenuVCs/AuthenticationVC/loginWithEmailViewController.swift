//
//  loginWithEmailViewController.swift
//  Bazaar
//
//  Created by Amal Elgalant on 17/04/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH
import NVActivityIndicatorView

class loginWithEmailViewController: UIViewController {
    //Outlets
   
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
        // Do any additional setup after loading the view.
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
            emailTxtField.textAlignment = .right
            passwordTxtField.textAlignment = .right
        } else {
            emailView.layer.maskedCorners = [.layerMaxXMinYCorner]
            passwordView.layer.maskedCorners = [.layerMaxXMaxYCorner]
            registerView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
            emailTxtField.textAlignment = .left
            passwordTxtField.textAlignment = .left
        }
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension loginWithEmailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
