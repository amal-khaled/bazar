//
//  SliderAdDetailsViewController.swift
//  Bazaar
//
//  Created by Amal Elgalant on 05/11/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class SliderAdDetailsViewController: UIViewController {
var ad = Ad()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func callNowAction(_ sender: Any) {
        if ad.PhoneNumber == "" {
            let alert = UIAlertController(title: "", message: "There is no number for this ad".localized, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }
        else {
            if let url = NSURL(string: "tel://\(ad.PhoneNumber)"), UIApplication.shared.canOpenURL(url as URL) {
              UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func sendMsgAction(_ sender: Any) {
        if ad.whatsAppNumber == "" {
            let alert = UIAlertController(title: "", message: "There is no whatsapp for this ad".localized, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }
        else {
            var index = AppDelegate.countries.firstIndex(where: {$0.id == AppDelegate.cityId}) ?? 0
           
            let urlWhats = "https://wa.me/\("\(AppDelegate.countries[index].code ?? "965")" + ad.whatsAppNumber)"
            if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
                if let whatsappURL = URL(string: urlString) {
                    if UIApplication.shared.canOpenURL(whatsappURL){
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(whatsappURL)
                        }
                    }
                    else {
                        
                    }
                }
            }
            
        }
        
    }
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
