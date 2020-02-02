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
    

    override func viewDidLoad() {
        super.viewDidLoad()
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
}
