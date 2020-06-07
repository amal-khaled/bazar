//
//  ContactUsVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class ContactUsVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var subjectTxtField: UITextField!
    @IBOutlet weak var messageTxtView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var youTubeBtn: UIButton!
    @IBOutlet weak var twitterBtn: UIButton!
    @IBOutlet weak var instagramBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.isHidden = true
        setupView()
    }
    
    func setupView() {
        self.navigationController?.navigationBar.addCornerRadius(cornerRadius: 25)
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        firstView.addCornerRadius(cornerRadius: 20)
        firstView.addBorder()
        secondView.addCornerRadius(cornerRadius: 20)
        secondView.addBorder()
        emailTxtField.addBorder()
        emailTxtField.addCornerRadius(cornerRadius: 15)
        phoneTxtField.addCornerRadius(cornerRadius: 15)
        phoneTxtField.addBorder()
        subjectTxtField.addCornerRadius(cornerRadius: 15)
        subjectTxtField.addBorder()
        messageTxtView.addBorder()
        messageTxtView.addCornerRadius(cornerRadius: 25)
        sendBtn.addCornerRadius(cornerRadius: 15)
        emailTxtField.delegate = self
        phoneTxtField.delegate = self
        subjectTxtField.delegate = self
        messageTxtView.delegate = self
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toMain", sender: self)
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {

        if NetworkHelper.getToken() != nil {
            guard let email = emailTxtField.text, emailTxtField.text != "" else {return}
            guard let phone = phoneTxtField.text, phoneTxtField.text != "" else {return}
            guard let subject = subjectTxtField.text, subjectTxtField.text != "" else {return}
            guard let message = messageTxtView.text, messageTxtView.text != "" else {return}
            self.indicator.isHidden = false
            self.indicator.startAnimating()
            let parameters = [
               "Email" : email,
               "PhoneNumber": phone,
               "Subject": subject,
               "Message": message
               ]
            
            Alamofire.request(CONTACTUS_URL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: HEADER_BOTH).responseJSON { (response) in
                switch response.result {
                case .failure(let error):
                    print(error)
                case .success(let value):
                    _ = JSON(value)
                    let alert = UIAlertController(title: "", message: "Your Messege have successfully sent".localized, preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    let when = DispatchTime.now() + 3
                    DispatchQueue.main.asyncAfter(deadline: when){
                        alert.dismiss(animated: true) {
                            self.emailTxtField.text = ""
                            self.phoneTxtField.text = ""
                            self.subjectTxtField.text = ""
                            self.messageTxtView.text = ""
                            self.indicator.stopAnimating()
                            self.indicator.isHidden = true
                        }
                    }

                }
            }
        } else {
        let alert = UIAlertController(title: "", message: "You Should login first".localized, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
        }
    }
    
    @IBAction func locationBtnPressed(_ sender: Any) {
    }
    
    @IBAction func phoneBtnPressed(_ sender: Any) {
    }
    
    @IBAction func emailBtnPressed(_ sender: Any) {
    }
    
    @IBAction func youtubeBtnPressed(_ sender: Any) {
    }
    
    @IBAction func twitterBtnPressed(_ sender: Any) {
    }
    
    @IBAction func instagramBtnPressed(_ sender: Any) {
//        let url = URL(string: "https://instagram.com/a3lanate.kw?igshid=1fgm528hsgly2")
//        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    @IBAction func facebookBtnPressed(_ sender: Any) {
    }
}

extension ContactUsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ContactUsVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
