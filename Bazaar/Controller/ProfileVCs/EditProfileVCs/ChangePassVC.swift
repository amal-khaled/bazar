//
//  ChangePassVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ChangePassVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var exitBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var currentPassTxtField: UITextField!
    @IBOutlet weak var newPassTxtField: UITextField!
    @IBOutlet weak var confirmPassTxtField: UITextField!
    @IBOutlet weak var changeBtn: UIButton!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.isHidden = true
        setupView()
    }
    
    func setupView() {
        mainView.addCornerRadius(cornerRadius: 30)
        mainView.addBorder()
        changeBtn.addCornerRadius(cornerRadius: 15)
        currentPassTxtField.delegate = self
        newPassTxtField.delegate = self
        confirmPassTxtField.delegate = self
    }
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeBtnPressed(_ sender: Any) {
        let changePassAlert = ChangePassAlert()
        changePassAlert.modalPresentationStyle = .custom
        present(changePassAlert, animated: true, completion: nil)
    }
}

extension ChangePassVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
