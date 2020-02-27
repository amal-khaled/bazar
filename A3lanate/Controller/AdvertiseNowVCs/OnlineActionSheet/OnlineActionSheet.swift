//
//  OnlineActionSheet.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/9/20.
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
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    //Variables
    var adId: Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        actionSheetView.addCornerRadius(cornerRadius: 50)
        actionSheetView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        yesBtn.addCornerRadius(cornerRadius: 20)
        cancelBtn.addCornerRadius(cornerRadius: 20)
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(PayActionSheet.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
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
    
    @IBAction func yesBtnPressed(_ sender: Any) {
        pay()
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
