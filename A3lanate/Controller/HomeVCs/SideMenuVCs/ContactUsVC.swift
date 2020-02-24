//
//  ContactUsVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 1/28/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
