//
//  RegisterVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/2/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

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
        emailView.layer.maskedCorners = [.layerMaxXMinYCorner]
        emailView.addBorder(borderWidth: 1, borderColor: #colorLiteral(red: 0, green: 0.5594217181, blue: 0.3978024721, alpha: 1))
        confirmPassView.addCornerRadius(cornerRadius: 45)
        confirmPassView.layer.maskedCorners = [.layerMaxXMaxYCorner]
        confirmPassView.addBorder(borderWidth: 1, borderColor: #colorLiteral(red: 0, green: 0.5594217181, blue: 0.3978024721, alpha: 1))
        phoneView.addBorder(borderWidth: 1, borderColor: #colorLiteral(red: 0, green: 0.5594217181, blue: 0.3978024721, alpha: 1))
        passView.addBorder(borderWidth: 1, borderColor: #colorLiteral(red: 0, green: 0.5594217181, blue: 0.3978024721, alpha: 1))
        phoneBtn.addCornerRadius(cornerRadius: 35)
        loginView.addCornerRadius(cornerRadius: 40)
        loginView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
        loginView.addBorder(borderWidth: 1, borderColor: UIColor.gray.cgColor)
        phoneBtn.isHidden = true
    }
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toMain", sender: self)
    }
    
    @IBAction func phoneBtnPressed(_ sender: Any) {
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
