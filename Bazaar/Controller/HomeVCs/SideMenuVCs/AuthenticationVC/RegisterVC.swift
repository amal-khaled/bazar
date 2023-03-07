//
//  RegisterVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH
import NVActivityIndicatorView

class RegisterVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var exitBtn: UIButton!
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var emailUnderView: UIView!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var phoneUnderView: UIView!
    
    @IBOutlet weak var phoneeContentView: UIView!
    @IBOutlet weak var emailContnetView: UIView!
    
    //Variable
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailContnetView.isHidden = true
        phoneeContentView.isHidden = false
    }
    
 
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func emailBtnAction(_ sender: Any) {
        emailBtn.setTitleColor(#colorLiteral(red: 0, green: 0.1060060635, blue: 0.4046606719, alpha: 1), for: .normal)
        emailUnderView.backgroundColor = #colorLiteral(red: 0, green: 0.1060060635, blue: 0.4046606719, alpha: 1)
        phoneBtn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        phoneUnderView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        emailContnetView.isHidden = false
        phoneeContentView.isHidden = true
    }
    
   
    @IBAction func phoneButtonAction(_ sender: Any) {
        phoneBtn.setTitleColor(#colorLiteral(red: 0, green: 0.1060060635, blue: 0.4046606719, alpha: 1), for: .normal)
        phoneUnderView.backgroundColor = #colorLiteral(red: 0, green: 0.1060060635, blue: 0.4046606719, alpha: 1)
        emailBtn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        emailUnderView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        emailContnetView.isHidden = true
        phoneeContentView.isHidden = false
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "register_email" {
            if let childVC = segue.destination as? RegisterWithEmailViewController {
                //Some property on ChildVC that needs to be set
                //            childVC.dataSource = self
            }
        }
    }
  
    
    
 
}


