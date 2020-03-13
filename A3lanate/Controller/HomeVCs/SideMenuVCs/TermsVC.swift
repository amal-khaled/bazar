//
//  TermsVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 1/29/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MOLH

class TermsVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var contentLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadData()
    }
    
    func setupView() {
        self.navigationController?.navigationBar.addCornerRadius(cornerRadius: 25)
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        scrollView.addBorder()
        scrollView.addCornerRadius(cornerRadius: 20)
    }
    
    func loadData() {
        Alamofire.request(TERMS_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let value):
                let json = JSON(value)
                if MOLHLanguage.isArabic() {
                    if let text = json["Text"].string {
                        self.contentLbl.text = text
                    }
                } else {
                    if let text = json["TextEN"].string {
                        self.contentLbl.text = text
                    }
                }
            }
        }
    }

    
    @IBAction func backBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toMain", sender: self)
    }
}
