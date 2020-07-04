//
//  OnlineActionSheet.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH
import Alamofire
import SwiftyJSON
import SafariServices

class OnlineActionSheet: UIViewController {
    
    //Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var actionSheetView: UIView!
    @IBOutlet weak var payBtn: UIButton!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var featureLbl: UILabel!
    @IBOutlet weak var balanceLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var unpayedLbl: UILabel!
    
    //Variables
    var adId: Int = 0
    var adPrice: Double = 0.0
    var AdFeatures: Double = 0.0
    var Total: Double = 0.0
    var PayedTotal: Double = 0.0
    var UnPayedTotal: Double = 0.0
    var FreeBalance: Double = 0.0
    var UserBlance: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadRecipt()
    }
    
    func setupView() {
        actionSheetView.addCornerRadius(cornerRadius: 50)
        actionSheetView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        payBtn.addCornerRadius(cornerRadius: 20)
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(PayActionSheet.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    func loadRecipt() {
        self.priceLbl.text = "\(adPrice)"
        self.featureLbl.text = "\(Total - adPrice)"
        self.balanceLbl.text = "\(UserBlance)"
        self.totalLbl.text = "\(Total)"
        self.unpayedLbl.text = "\(UnPayedTotal)"
    }
    
    func pay() {
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
        
        Alamofire.request(PAY_ONLINE_URL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: HEADER_BOTH).responseString { (response) in
            if response.result.error == nil {
                let value = response.result.value
                let json = JSON(value as Any)
                if let url = json.string {
                    var ur: String = ""
                    ur = url
                    ur.removeFirst()
                    ur.removeLast()
                    UIApplication.shared.open(URL(string: ur.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!, options: [:], completionHandler: nil)
                }
            } else {
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func payBtnPressed(_ sender: Any) {
//        pay()
        let paymentMethodsVC = PaymentMethodsVC()
        paymentMethodsVC.modalPresentationStyle = .custom
        paymentMethodsVC.modalTransitionStyle = .crossDissolve
        paymentMethodsVC.adId = self.adId
        self.present(paymentMethodsVC, animated: true, completion: nil)
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
