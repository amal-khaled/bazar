//
//  LanguageVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 1/27/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH

class LanguageVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var englishBtn: UIButton!
    @IBOutlet weak var arabicBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            arabicBtn.backgroundColor = #colorLiteral(red: 0.932130754, green: 0.6688258052, blue: 0, alpha: 1)
            arabicBtn.setTitleColor(.white, for: .normal)
            englishBtn.backgroundColor = UIColor.white
            englishBtn.setTitleColor(.black, for: .normal)
        } else {
            englishBtn.backgroundColor = #colorLiteral(red: 0.932130754, green: 0.6688258052, blue: 0, alpha: 1)
            englishBtn.setTitleColor(.white, for: .normal)
            arabicBtn.backgroundColor = UIColor.white
            arabicBtn.setTitleColor(.black, for: .normal)   }
    }
    
    func setupView() {
        self.navigationController?.navigationBar.addCornerRadius(cornerRadius: 25)
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        englishBtn.addCornerRadius(cornerRadius: 5)
        arabicBtn.addCornerRadius(cornerRadius: 5)
        saveBtn.addShadowWithCorner(cornerRadius: 5, shadowColor: UIColor.black.cgColor, shadowOpacity: 0.3, shadowOffset: .zero, shadowRadius: 3)
    }
    
    @IBAction func englishBtnPressed(_ sender: Any) {
        englishBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5594217181, blue: 0.3978024721, alpha: 1)
        englishBtn.setTitleColor(.white, for: .normal)
        arabicBtn.backgroundColor = UIColor.white
        arabicBtn.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func arabicBtnPressed(_ sender: Any) {
        arabicBtn.backgroundColor = #colorLiteral(red: 0, green: 0.5594217181, blue: 0.3978024721, alpha: 1)
        arabicBtn.setTitleColor(.white, for: .normal)
        englishBtn.backgroundColor = UIColor.white
        englishBtn.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        if englishBtn.backgroundColor == #colorLiteral(red: 0, green: 0.5594217181, blue: 0.3978024721, alpha: 1) {
            MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
            if #available(iOS 13.0, *) {
                    let delegate = UIApplication.shared.delegate as? AppDelegate
                    delegate!.swichRoot()
            } else {
                   // Fallback on earlier versions
                   MOLH.reset()
            }
            
        } else {
            MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "ar")
                    if #available(iOS 13.0, *) {
                    let delegate = UIApplication.shared.delegate as? AppDelegate
                    delegate!.swichRoot()
            } else {
                   // Fallback on earlier versions
                   MOLH.reset()
            }
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toMain", sender: self)
    }
    
}
