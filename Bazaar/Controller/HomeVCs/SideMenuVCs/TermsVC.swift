//
//  TermsVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MOLH
import NVActivityIndicatorView

class TermsVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
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
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
        }
    }

    
    @IBAction func backBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toMain", sender: self)
    }
}
