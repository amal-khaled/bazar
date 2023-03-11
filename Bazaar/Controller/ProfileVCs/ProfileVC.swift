//
//  ProfileVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class ProfileVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameBtn: UIButton!
    @IBOutlet weak var myAdsBtn: UIButton!
    @IBOutlet weak var balanceBtn: UIButton!
    @IBOutlet weak var paymentBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    
    @IBOutlet weak var loginOrRegisterBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var myAdsImg: LocalizedImage!
    @IBOutlet weak var balanceImg: LocalizedImage!
    @IBOutlet weak var paymentImg: LocalizedImage!
    @IBOutlet weak var notifImg: LocalizedImage!
    @IBOutlet weak var FavoriteBtn: UIButton!
    @IBOutlet weak var favoriteImg: LocalizedImage!
    @IBOutlet weak var notifCountLbl: UILabel!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    
    @IBOutlet weak var profileView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if NetworkHelper.getToken() == nil {
            let alert = UIAlertController(title: "", message: "You Should login first".localized, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true) {
                    self.performSegue(withIdentifier: "toLoginVC", sender: self)
                }
            }
        } else {
            indicator.startAnimating()
            loadProfile()
            setupView()
        }
    }
    
    @IBAction func EditProfile(_ sender: Any) {
        performSegue(withIdentifier: "toEditProfileVC", sender: self)
    }
    
    
    func setupView() {
        
//        profileView.addBorder(toSide: .Bottom, withColor: #colorLiteral(red: 0.07843137255, green: 0.2705882353, blue: 0.4588235294, alpha: 1), andThickness: 1.0)
//        self.navigationController?.navigationBar.addCornerRadius(cornerRadius: 25)
//        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
//        self.navigationController?.navigationBar.isHidden = true
        
        self.tabBarController?.tabBar.addCornerRadius(cornerRadius: 25)
        self.tabBarController?.tabBar.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        
        profileImg.addBorder(borderWidth: 2, borderColor:#colorLiteral(red: 0.07843137255, green: 0.2705882353, blue: 0.4588235294, alpha: 1) )
        profileImg.addCornerRadius(cornerRadius: 45)
//        myAdsImg.addCornerRadius(cornerRadius: 35)
//        balanceImg.addCornerRadius(cornerRadius: 35)
//        paymentImg.addCornerRadius(cornerRadius: 35)
//        notifImg.addCornerRadius(cornerRadius: 35)
//        favoriteImg.addCornerRadius(cornerRadius: 35)
    }
    @IBAction func ordersBtnAction(_ sender: Any) {
        basicNavigation(storyName: "Store", segueId: "myorders")
    }
    
    func loadProfile() {
        print(HEADER_AUTH)
        Alamofire.request(PROFILE_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER_AUTH).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            case .success(let value):
                let json = JSON(value)
                print(json)
                if let name = json["Name"].string {
                    self.nameBtn.setTitle(name, for: .normal)
                }
                if let image = json["ImageURL"].string {
                    Alamofire.request(image).responseImage { (response) in
                        if let image = response.result.value {
                            DispatchQueue.main.async {
                                self.profileImg.image = image
                                self.profileImg.contentMode = .scaleAspectFill
                            }
                        }
                    }
                }
                if let city = json["City"].dictionary {
                    AppDelegate.defaults.setValue(city["CityId"]?.int ?? 0, forKey: "userCity")

                }
               
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
        }
        
        NotificationService.instance.getNotifications { (error, notifications) in
            if let notifications = notifications {
                self.notifCountLbl.text = "\(notifications.count)"
            }
        }
    }
    
    @IBAction func nameBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toEditProfileVC", sender: self)
    }
    
    @IBAction func myAdsBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toMyAdsVC", sender: self)
    }
    
    @IBAction func balanceBtnPressed(_ sender: Any) {
//        performSegue(withIdentifier: "toBalanceVC", sender: self)
        let buyPackageVC = BuyPackageVC()
        buyPackageVC.modalPresentationStyle = .custom
        buyPackageVC.modalTransitionStyle = .crossDissolve
        present(buyPackageVC, animated: true, completion: nil)
    }
    
    @IBAction func paymentBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toPaymentVC", sender: self)
    }
    
    @IBAction func notificationBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toNotificationVC", sender: self)
    }
    
    @IBAction func favoriteBtnPressed(_ sender: Any) {
        self.tabBarController?.selectedIndex = 3
    }
    
}
