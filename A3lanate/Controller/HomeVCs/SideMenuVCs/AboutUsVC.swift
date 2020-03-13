//
//  AboutUsVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 1/28/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MOLH

class AboutUsVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadData()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toMain", sender: self)
    }
    
    func setupView() {
        self.navigationController?.navigationBar.addCornerRadius(cornerRadius: 25)
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        scrollView.addBorder()
        scrollView.addCornerRadius(cornerRadius: 20)
    }
    
    func loadData() {
        Alamofire.request(ABOUTUS_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let value):
                let json = JSON(value)
                if MOLHLanguage.isArabic() {
                    if let text = json["Text"].string {
                        self.detailsLbl.text = text
                    }
                } else {
                    if let text = json["TextEN"].string {
                        self.detailsLbl.text = text
                    }
                }
            }
        }
    }
}
