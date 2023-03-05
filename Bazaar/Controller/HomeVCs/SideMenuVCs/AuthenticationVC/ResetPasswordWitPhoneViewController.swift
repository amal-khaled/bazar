//
//  ResetPasswordWitPhoneViewController.swift
//  Bazaar
//
//  Created by Amal Elgalant on 20/04/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import FirebaseAuth

class ResetPasswordWitPhoneViewController: UIViewController {
    //Outlets
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passTxtField: UITextField!
    @IBOutlet weak var passEyeBtn: UIButton!
    @IBOutlet weak var codeTxtField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var codeView: UIView!
    var verificationId = ""

    //Variable
    var passeyeClick = true
    var phone: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        emailTxtField.delegate = self
        passTxtField.delegate = self
        codeTxtField.delegate = self
        emailTxtField.text = phone
        emailView.addBorder(borderWidth: 1, borderColor: #colorLiteral(red: 0.001686832751, green: 0.1439712048, blue: 0.4857619405, alpha: 1))
        emailView.addCornerRadius(cornerRadius: 15)
        passView.addBorder(borderWidth: 1, borderColor: #colorLiteral(red: 0.001686832751, green: 0.1439712048, blue: 0.4857619405, alpha: 1))
        passView.addCornerRadius(cornerRadius: 15)
        codeView.addBorder(borderWidth: 1, borderColor: #colorLiteral(red: 0.001686832751, green: 0.1439712048, blue: 0.4857619405, alpha: 1))
        codeView.addCornerRadius(cornerRadius: 15)
    }
    
    @IBAction func dismissBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func passEyeBtnPressed(_ sender: Any) {
        if(passeyeClick == true) {
            passTxtField.isSecureTextEntry = false
        } else {
            passTxtField.isSecureTextEntry = true
        }
        passeyeClick = !passeyeClick
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        guard let pass = passTxtField.text, passTxtField.text != "" else {return}
        guard let code = codeTxtField.text, codeTxtField.text != "" else {return}

        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: code)
        Auth.auth().signIn(with: credential, completion: {
            authData, error in
            if error != nil{
                let alert = UIAlertController(title: "", message: "enter right code".localized, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                let when = DispatchTime.now() + 2
                DispatchQueue.main.asyncAfter(deadline: when){
                    alert.dismiss(animated: true) {
                    }
                }
                
            }
            else{
                AuthService.instance.resetPasswordWithPhone(phone: self.phone, checkCode: code, pass: pass) { (success, msg) in
                    if success {
                        let alert = UIAlertController(title: "", message: "Your password changed".localized, preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        let when = DispatchTime.now() + 2
                        DispatchQueue.main.asyncAfter(deadline: when){
                            alert.dismiss(animated: true) {
                                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                            }
                        }
                    }else{
                        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        let when = DispatchTime.now() + 2
                        DispatchQueue.main.asyncAfter(deadline: when){
                            alert.dismiss(animated: true) {
                            }
                        }
                    }
                }
                
            }
        })
        
        
        
       
    }
}

extension ResetPasswordWitPhoneViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
