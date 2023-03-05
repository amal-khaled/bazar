//
//  forgotPassVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class forgotPassVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var exitBtn: UIButton!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    //Variables
    var mail: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.isHidden = true
        setupView()
    }
    
    func setupView() {
        emailView.addBorder()
        emailView.addCornerRadius(cornerRadius: 35)
        sendBtn.addCornerRadius(cornerRadius: 20)
        emailTxtField.delegate = self

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResetPassVC" {
            let destVC = segue.destination as! ResetPassVC
            destVC.mail = self.mail
        }
    }
    
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        guard let email = emailTxtField.text, emailTxtField.text != "" else {return}
        self.indicator.isHidden = false
        self.indicator.startAnimating()
        AuthService.instance.forgetPassword(email: email) { (success, msg) in
            if success {
                self.mail = email
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                self.emailTxtField.text = ""
                self.emailTxtField.placeholder = "Email".localized
                let alert = UIAlertController(title: "", message: "Please check your Email.".localized, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                let when = DispatchTime.now() + 2
                DispatchQueue.main.asyncAfter(deadline: when){
                    alert.dismiss(animated: true) {
                        self.performSegue(withIdentifier: "toResetPassVC", sender: self)
                    }
                }
            }else{
                self.indicator.stopAnimating()

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
}

extension forgotPassVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
