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
    }
    
    @IBAction func forgotPassBtnPressed(_ sender: Any) {
    }
    
    @IBAction func registerBtnPressed(_ sender: Any) {
    }
}
