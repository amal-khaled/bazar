//
//  SideMenuVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class SideMenuVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var exitBtn: UIButton!
    @IBOutlet weak var englishBtn: UIButton!
    @IBOutlet weak var arabicBtn: UIButton!
    @IBOutlet weak var notOnBtn: UIButton!
    @IBOutlet weak var notOffBtn: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        if NetworkHelper.getToken() == nil {
//            loginLbl.text = "Log In".localized
//        } else {
//            loadProfile()
//            loginLbl.text = "Log Out".localized
//        }
        
    }
    
    func setupView() {
//        profileImg.addBorder(borderWidth: 2, borderColor: #colorLiteral(red: 0.932130754, green: 0.6688258052, blue: 0, alpha: 1))
//        profileImg.addCornerRadius(cornerRadius: 75)
//        countryLbl.addCornerRadius(cornerRadius: 15)
//        notificationLbl.addCornerRadius(cornerRadius: 15)
//        languageLbl.addCornerRadius(cornerRadius: 15)
//        termsLbl.addCornerRadius(cornerRadius: 15)
//        supportLbl.addCornerRadius(cornerRadius: 15)
//        contactUsLbl.addCornerRadius(cornerRadius: 15)
//        shareLbl.addCornerRadius(cornerRadius: 15)
//        aboutUsLbl.addCornerRadius(cornerRadius: 15)
//        loginLbl.addCornerRadius(cornerRadius: 15)
    }
    
    func loadProfile() {
        Alamofire.request(PROFILE_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER_AUTH).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let value):
                let json = JSON(value)
//                if let name = json["Name"].string {
//                    self.usernameLbl.text = name
//                }
                if let image = json["ImageURL"].string {
                    Alamofire.request(image).responseImage { (response) in
                        if let image = response.result.value {
                            DispatchQueue.main.async {
                               // self.profileImg.contentMode = .scaleAspectFill
                            }
                        }
                    }
                }
            }
        }
        
        NotificationService.instance.getNotifications { (error, notifications) in
//            if let notifications = notifications {
//                self.notifCountLbl.text = "\(notifications.count)"
//            }
        }
    }
    
    
    //MARK: IBActions 
    
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
        let countryList = CountryListVC()
        countryList.modalPresentationStyle = .fullScreen
        countryList.modalTransitionStyle = .crossDissolve
        present(countryList, animated: true, completion: nil)
    }
    
    @IBAction func notificationBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toNotificationVC", sender: self)
    }
    
    
    @IBAction func commenAsksBtnPressed(_ sender: UIButton) {
        print("common Button")
    }
    
    @IBAction func termsBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toTermsVC", sender: self)
    }
    
    @IBAction func supportBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toSupportVC", sender: self)
    }
    
    
    @IBAction func privacyBtnPressed(_ sender: UIButton) {
        print("privacy Btn Pressed")
    }
    
    
    @IBAction func rateAppBtnPressed(_ sender: UIButton) {
        
        print(" Rate App ")
    }
    
    
    @IBAction func shareBtnPressed(_ sender: Any) {
        
        let text = "Download the app from this link: ".localized + "http://itunes.apple.com/app/id1511596620"
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if NetworkHelper.getToken() == nil {
            performSegue(withIdentifier: "toLoginVC", sender: self)
        } else {
            let alert = UIAlertController(title: "Log Out".localized, message: "Are you sure you want to sign out?".localized , preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes".localized, style: .default , handler:{ (UIAlertAction)in
                NetworkHelper.removeToken()
            }))
            
            alert.addAction(UIAlertAction(title: "No".localized, style: .cancel, handler:{ (UIAlertAction)in
                self.dismiss(animated: true, completion: nil)
            }))
            addActionSheetForiPad(actionSheet: alert)
            self.present(alert, animated: true, completion: {
            })        }
    }
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
