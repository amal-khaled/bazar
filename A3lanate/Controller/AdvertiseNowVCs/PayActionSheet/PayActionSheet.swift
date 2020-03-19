//
//  PayActionSheet.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/9/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MOLH

class PayActionSheet: UIViewController {
    
    //Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var actionSheetView: UIView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var balanceBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    //Outlets
    var adId: Int = 0
    
    //Variables
    var featureVC = FeaturesVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadData()
    }
    
    func setupView() {
        actionSheetView.addCornerRadius(cornerRadius: 50)
        actionSheetView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        onlineBtn.addCornerRadius(cornerRadius: 20)
        balanceBtn.addCornerRadius(cornerRadius: 20)
        cancelBtn.addCornerRadius(cornerRadius: 20)
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(PayActionSheet.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    func loadData() {
        var parameters = [String: Any]()
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            parameters = [
               "AdId" : adId,
               "Lang": "ar",
               ]
        } else {
            parameters = [
               "AdId" : adId,
               "Lang": "en",
               ]
        }
        
        Alamofire.request(PAY_URL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: HEADER_BOTH).responseJSON { (response) in
            if response.result.error == nil {
                if let json = response.result.value as? Dictionary<String,Any> {
                    if let status = json["Status"] as? Int {
                        if status == 1 {
                            let alert = UIAlertController(title: "", message: "Your Ad got uploaded successfully".localized, preferredStyle: .alert)
                            self.present(alert, animated: true, completion: nil)
                            let when = DispatchTime.now() + 3
                            DispatchQueue.main.asyncAfter(deadline: when){
                                alert.dismiss(animated: true) {
                                    self.presentingViewController?.dismiss(animated: true, completion: nil)
                                    if #available(iOS 13.0, *) {
                                            let delegate = UIApplication.shared.delegate as? AppDelegate
                                            delegate!.swichRoot()
                                    } else {
                                           // Fallback on earlier versions
                                           MOLH.reset()
                                    }
                                }
                            }
                        }
                        else if status == 2 {
                            let alert = UIAlertController(title: "", message: "Your Ad got uploaded successfully, to activate features please pay".localized, preferredStyle: .alert)
                            self.present(alert, animated: true, completion: nil)
                            let when = DispatchTime.now() + 3
                            DispatchQueue.main.asyncAfter(deadline: when){
                                alert.dismiss(animated: true, completion: nil)
                            }
                        }
                        else if status == 3 {
                            let alert = UIAlertController(title: "", message: "You don't have enough balance so you need to pay to upload your ad".localized, preferredStyle: .alert)
                            self.present(alert, animated: true, completion: nil)
                            let when = DispatchTime.now() + 3
                            DispatchQueue.main.asyncAfter(deadline: when){
                                alert.dismiss(animated: true, completion: nil)
                            }
                        }
                    }
                } else {
                    debugPrint(response.result.error as Any)
                }
            }
        }
    }
                
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onlineBtnPressed(_ sender: Any) {
        let onlineActionSheet = OnlineActionSheet()
        onlineActionSheet.adId = self.adId
        onlineActionSheet.modalPresentationStyle = .custom
        present(onlineActionSheet, animated: true, completion: nil)
    }
    
    @IBAction func balanceBtnPressed(_ sender: Any) {
        var parameters = [String: Any]()
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            parameters = [
               "AdId" : adId,
               "Lang": "ar",
               ]
        } else {
            parameters = [
               "AdId" : adId,
               "Lang": "en",
               ]
        }
        Alamofire.request(PAY_FROMPACKAGE_URL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: HEADER_BOTH).responseJSON { (response) in
            if response.result.error == nil {
                if let json = response.result.value as? Dictionary<String,Any> {
                    if let refrence = json["ReferenceNumber"] as? String {
                            let alert = UIAlertController(title: "", message: "Your Ad got uploaded successfully".localized, preferredStyle: .alert)
                            self.present(alert, animated: true, completion: nil)
                            let when = DispatchTime.now() + 3
                            DispatchQueue.main.asyncAfter(deadline: when){
                                alert.dismiss(animated: true, completion: nil)
                            }
                            self.dismiss(animated: true, completion: nil)
                    }
                    if let message = json["Message"] as? String {
                        let alertController = UIAlertController(title: message, message: "Do you want to buy more?".localized, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK".localized, style: UIAlertAction.Style.default) {
                                UIAlertAction in
                            
                            let buyPackageVC = BuyPackageVC()
                            buyPackageVC.modalPresentationStyle = .custom
                            buyPackageVC.modalTransitionStyle = .crossDissolve
                            self.present(buyPackageVC, animated: true, completion: nil)
                            }
                        let cancelAction = UIAlertAction(title: "Cancel".localized, style: UIAlertAction.Style.cancel) {
                                UIAlertAction in
                            }
                            alertController.addAction(okAction)
                            alertController.addAction(cancelAction)
                            self.present(alertController, animated: true, completion: nil)
                    }
                } else {
                    debugPrint(response.result.error as Any)
                }
            }
        }
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
