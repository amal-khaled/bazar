//
//  SideMenuVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 1/27/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var languageBtn: UIButton!
    @IBOutlet weak var aboutUsBtn: UIButton!
    @IBOutlet weak var contactUsBtn: UIButton!
    @IBOutlet weak var countryBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var supportBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var exitBtn: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var notificationLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var termsLbl: UILabel!
    @IBOutlet weak var supportLbl: UILabel!
    @IBOutlet weak var contactUsLbl: UILabel!
    @IBOutlet weak var shareLbl: UILabel!
    @IBOutlet weak var aboutUsLbl: UILabel!
    @IBOutlet weak var loginLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        profileImg.addBorder(borderWidth: 2, borderColor: #colorLiteral(red: 0, green: 0.5594217181, blue: 0.3978024721, alpha: 1))
        profileImg.addCornerRadius(cornerRadius: 75)
        countryLbl.addCornerRadius(cornerRadius: 15)
        notificationLbl.addCornerRadius(cornerRadius: 15)
        languageLbl.addCornerRadius(cornerRadius: 15)
        termsLbl.addCornerRadius(cornerRadius: 15)
        supportLbl.addCornerRadius(cornerRadius: 15)
        contactUsLbl.addCornerRadius(cornerRadius: 15)
        shareLbl.addCornerRadius(cornerRadius: 15)
        aboutUsLbl.addCornerRadius(cornerRadius: 15)
        loginLbl.addCornerRadius(cornerRadius: 15)
    }
    
    @IBAction func languageBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toLanguageVC", sender: self)
    }
    
    @IBAction func aboutUsBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toAboutVC", sender: self)
    }
    
    @IBAction func contactUsBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toContactusVC", sender: self)
    }
    
    @IBAction func countryBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toCountryVC", sender: self)
    }
   
    @IBAction func notificationBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toNotificationVC", sender: self)
    }
    
    @IBAction func termsBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toTermsVC", sender: self)
    }
    
    @IBAction func supportBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toSupportVC", sender: self)
    }
    
    @IBAction func shareBtnPressed(_ sender: Any) {
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toLoginVC", sender: self)
    }
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
