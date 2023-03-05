//
//  ConfirmViewController.swift
//  Bazaar
//
//  Created by Amal Elgalant on 20/04/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import FirebaseAuth

class ConfirmViewController: UIViewController {
    
    @IBOutlet weak var codeView: UIView!
    @IBOutlet weak var activityInticator: NVActivityIndicatorView!
    @IBOutlet weak var codeTF: UITextField!
    var phone: String = ""
    var cityId = ""
    var password = ""
    var verificationId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        // Do any additional setup after loading the view.
    }
    func setupView() {
        
        codeTF.delegate = self
        
        codeView.addBorder(borderWidth: 1, borderColor: #colorLiteral(red: 0.001686832751, green: 0.1439712048, blue: 0.4857619405, alpha: 1))
        codeView.addCornerRadius(cornerRadius: 15)
    }
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveBtnAction(_ sender: Any) {
        
        
        guard let code = codeTF.text, codeTF.text != "" else {return}
        
        
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
                AuthService.instance.cofirmMobile(checkCode: code,phone: self.phone, cityId: self.cityId, password: self.password) { (success, msg) in
                    if success {
                        AuthService.instance.loginUserWithPhone(phone: self.phone, password: self.password, cityID: self.cityId) { (success) in
                            if success {
                            }
                            //                    self.indicator.stopAnimating()
                            //                    self.indicator.isHidden = true
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension ConfirmViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
