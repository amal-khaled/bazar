//
//  ForgetPasswordWithPhoneViewController.swift
//  Bazaar
//
//  Created by Amal Elgalant on 20/04/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import MOLH
import FirebaseAuth

class ForgetPasswordWithPhoneViewController: UIViewController {

    //Outlets
    @IBOutlet weak var exitBtn: UIButton!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    var veerificationId = ""

    @IBOutlet weak var countryFlagImageView: UIImageView!
    @IBOutlet weak var codeLabel: UILabel!
    //Variables
    var phone: String = ""
    var countryList = [country]()
    var selectedCountry = country()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCountryList()

        indicator.isHidden = true
        setupView()
    }
    
    func setupView() {
        phoneView.addBorder(borderWidth: 1.0, borderColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
//        phoneView.addCornerRadius(cornerRadius: 35)
        sendBtn.addCornerRadius(cornerRadius: 20)
        phoneTxtField.delegate = self

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResetPassVC" {
            let destVC = segue.destination as! ResetPasswordWitPhoneViewController
            destVC.phone = self.phone
            destVC.verificationId = self.veerificationId
        }
    }
    
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        guard let phone = phoneTxtField.text, phoneTxtField.text != "" && checkValidPhonNumber(Phone: "\(self.selectedCountry.code)\(phoneTxtField.text!)") else {
            
            StaticFunctions.createErrorAlert(msg: "enter valid phone number".localized, vc: self)
            return}
        self.indicator.isHidden = false
        self.indicator.startAnimating()
        AuthService.instance.forgetPasswordWithPhone(phone: phone) { (success, msg) in
            if success {
                
                PhoneAuthProvider.provider()
                    .verifyPhoneNumber("\(self.selectedCountry.code)\(self.phoneTxtField.text!)", uiDelegate: self) { verificationID, error in
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }
                        self.veerificationId = verificationID ?? ""

                        self.phone = phone
                        self.indicator.stopAnimating()
                        self.indicator.isHidden = true
                        self.phoneTxtField.text = ""
                        self.phoneTxtField.placeholder = "Phone".localized
                        let alert = UIAlertController(title: "", message: "Please check your Phone.".localized, preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        let when = DispatchTime.now() + 2
                        DispatchQueue.main.asyncAfter(deadline: when){
                            alert.dismiss(animated: true) {
                                self.performSegue(withIdentifier: "toResetPassVC", sender: self)
                            }
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


extension ForgetPasswordWithPhoneViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if codeLabel == textField {
//            if countryList.count > 0{
//                self.showCountryList()
//            }else{
//                self.getCountryList(show: true)
//            }
//            return false
//        }else{
//            return true
//        }
//    }
}
extension ForgetPasswordWithPhoneViewController{
    func showCountryList(){
        let alertController = UIAlertController(title: "Choose country".localized, message: "", preferredStyle: .actionSheet)
        
        for item in countryList{
            let superbutton = UIAlertAction(title: MOLHLanguage.currentAppleLanguage() == "ar" ? item.nameAr : item.nameEn , style: .default, handler: { (action) in
                self.codeLabel.text = item.code
                self.selectedCountry = item
            })
            
            alertController.addAction(superbutton)
        }
        let cancel = UIAlertAction(title: "Cancel".localized , style: .cancel, handler: { (action) in
            
            
        })
        alertController.addAction(cancel)
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view //to set the source of your alert
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
        }
        self.present(alertController, animated: true, completion: nil)
    }
    func getCountryList(show: Bool = false){

        UtilitiesService.instance.getCounties(completion: {
            check, countries in
            if check == 0 {
                self.countryList = countries
                if show{
                    self.showCountryList()
                }
            }else{
                self.showCountryList()

            }
        })
    }


}
extension ForgetPasswordWithPhoneViewController : AuthUIDelegate{
    
}
