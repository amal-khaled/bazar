//
//  LoginVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH
import NVActivityIndicatorView

class LoginVC: UIViewController {
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var emailUnderView: UIView!
    @IBOutlet weak var phoneUnderView: UIView!
    
    @IBOutlet weak var phoneContainer: UIView!
    @IBOutlet weak var emailContainer: UIView!
    
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var emailBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    @IBAction func emailAction(_ sender: UIButton) {
        emailBtn.setTitleColor(#colorLiteral(red: 0, green: 0.1060060635, blue: 0.4046606719, alpha: 1), for: .normal)
        emailUnderView.backgroundColor = #colorLiteral(red: 0, green: 0.1060060635, blue: 0.4046606719, alpha: 1)
        phoneBtn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        phoneUnderView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        emailContainer.isHidden = false
        phoneContainer.isHidden = true
    }
    
    @IBAction func phoneAction(_ sender: UIButton) {
        phoneBtn.setTitleColor(#colorLiteral(red: 0, green: 0.1060060635, blue: 0.4046606719, alpha: 1), for: .normal)
        phoneUnderView.backgroundColor = #colorLiteral(red: 0, green: 0.1060060635, blue: 0.4046606719, alpha: 1)
        emailBtn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        emailUnderView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        emailContainer.isHidden = true
        phoneContainer.isHidden = false
    }
    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toMain", sender: self)
    }
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "login_phone" {
            if let childVC = segue.destination as? LoginWithPhoneViewController {
                //Some property on ChildVC that needs to be set
                //            childVC.dataSource = self
            }
        }
    }
    
}

