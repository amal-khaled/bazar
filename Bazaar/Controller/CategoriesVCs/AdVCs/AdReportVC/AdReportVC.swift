//
//  AdReportVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AdReportVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var txtView: UITextView!
    
    var adId: Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        alertView.addCornerRadius(cornerRadius: 50)
        alertView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        txtView.addCornerRadius(cornerRadius: 20)
        txtView.addBorder()
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AdReportVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    func sendReport() {
        if NetworkHelper.getToken() != nil {
            guard let message = txtView.text, txtView.text != "" else {return}
            
            let parameters: [String:Any] = [
               "AdId" : adId,
               "Message": message
               ]
            
            Alamofire.request(AD_REPORT, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: HEADER_BOTH).responseJSON { (response) in
                switch response.result {
                case .failure(let error):
                    print(error)
                case .success(let value):
                    _ = JSON(value)
                    let alert = UIAlertController(title: "", message: "Your Messege have successfully sent".localized, preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    let when = DispatchTime.now() + 2
                    DispatchQueue.main.asyncAfter(deadline: when){
                        alert.dismiss(animated: true) {
                            self.txtView.text = ""
                            self.presentingViewController?.dismiss(animated: true, completion: nil)
                        }
                    }

                }
            }
        } else {
        let alert = UIAlertController(title: "", message: "You Should login first".localized, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        sendReport()
    }
    
}
