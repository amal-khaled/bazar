//
//  PaymentVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class PaymentVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var buyTokensBtn: UIButton!
    @IBOutlet weak var paymentHistoryBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buyTokensBtnPressed(_ sender: Any) {
        let buyPackageVC = BuyPackageVC()
        buyPackageVC.modalPresentationStyle = .custom
        buyPackageVC.modalTransitionStyle = .crossDissolve
        present(buyPackageVC, animated: true, completion: nil)
    }
    
    @IBAction func paymentHistoryBtnPressed(_ sender: Any) {
    }
}
