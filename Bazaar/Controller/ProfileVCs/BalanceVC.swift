//
//  BalanceVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BalanceVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var creditLbl: UILabel!
    @IBOutlet weak var freeCreditLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        Alamofire.request(PROFILE_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER_AUTH).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let value):
                let json = JSON(value)
                if let userBalance = json["UserBalance"].double {
                    self.creditLbl.text = "\(userBalance)"
                }
                if let freePackageBalance = json["FreePackageBalance"].double {
                    self.freeCreditLbl.text = "\(freePackageBalance)"
                }
            }
        }
    }
}
