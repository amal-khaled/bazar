//
//  ProfileVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 1/23/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON

class ProfileVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameBtn: UIButton!
    @IBOutlet weak var myAdsBtn: UIButton!
    @IBOutlet weak var balanceBtn: UIButton!
    @IBOutlet weak var paymentBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadProfile()
    }
    
    
    
    func setupView() {
        self.navigationController?.navigationBar.addCornerRadius(cornerRadius: 25)
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        self.tabBarController?.tabBar.addCornerRadius(cornerRadius: 25)
        self.tabBarController?.tabBar.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        profileImg.addBorder(borderWidth: 2, borderColor: #colorLiteral(red: 0, green: 0.5594217181, blue: 0.3978024721, alpha: 1))
        profileImg.addCornerRadius(cornerRadius: 65)
    }
    
    func loadProfile() {
        Alamofire.request(PROFILE_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER_AUTH).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let value):
                let json = JSON(value)
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
        performSegue(withIdentifier: "toBalanceVC", sender: self)
    }
    
    @IBAction func paymentBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toPaymentVC", sender: self)
    }
    
    @IBAction func notificationBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toNotificationVC", sender: self)
    }
}
