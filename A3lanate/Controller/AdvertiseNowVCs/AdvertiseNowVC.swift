//
//  AdvertiseNowVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 1/23/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class AdvertiseNowVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var uploadImgView: UIView!
    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var addImagesBtn: UIButton!
    @IBOutlet weak var descView: UIView!
    @IBOutlet weak var upperDescView: UIView!
    @IBOutlet weak var englishBtn: UIButton!
    @IBOutlet weak var arabicBtn: UIButton!
    @IBOutlet weak var desklineView: UIView!
    @IBOutlet weak var titleArTextField: UITextField!
    @IBOutlet weak var titleEnTextField: UITextField!
    @IBOutlet weak var priceTxtField: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var locTxtField: UITextField!
    @IBOutlet weak var allowDMBtn: UIButton!
    @IBOutlet weak var allowCallsBtn: UIButton!
    @IBOutlet weak var hidePhoneBtn: UIButton!
    @IBOutlet weak var republishBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var englishTxtView: UITextView!
    @IBOutlet weak var arabicTxtView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        self.navigationController?.navigationBar.addCornerRadius(cornerRadius: 25)
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        self.tabBarController?.tabBar.addCornerRadius(cornerRadius: 25)
        self.tabBarController?.tabBar.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        uploadImgView.addCornerRadius(cornerRadius: 25)
        addImagesBtn.addCornerRadius(cornerRadius: 25)
        addImagesBtn.addBorder()
        uploadImgView.addBorder()
        descView.addBorder()
        descView.addCornerRadius(cornerRadius: 25)
        descView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        titleArTextField.addCornerRadius(cornerRadius: 20)
        titleArTextField.addBorder()
        titleEnTextField.addCornerRadius(cornerRadius: 20)
        titleEnTextField.addBorder()
        priceTxtField.addCornerRadius(cornerRadius: 20)
        priceTxtField.addBorder()
        phoneTxtField.addCornerRadius(cornerRadius: 20)
        phoneTxtField.addBorder()
        locTxtField.addCornerRadius(cornerRadius: 20)
        locTxtField.addBorder()
        nextBtn.addCornerRadius(cornerRadius: 25)
        
    }
    
    @IBAction func uploadBtnPressed(_ sender: Any) {
    }
    
    @IBAction func addImageBtnPressed(_ sender: Any) {
    }
    
    @IBAction func englishBtnPressed(_ sender: Any) {
    }
    
    @IBAction func arabicBtnPressed(_ sender: Any) {
    }
    
    @IBAction func allowDMBtnPressed(_ sender: Any) {
    }
    
    @IBAction func allowOnlineCallsBtnPressed(_ sender: Any) {
    }
    
    @IBAction func hidePhoneBtnPressed(_ sender: Any) {
    }
    
    @IBAction func republishBtnPressed(_ sender: Any) {
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toPayVC", sender: self)
    }
}

