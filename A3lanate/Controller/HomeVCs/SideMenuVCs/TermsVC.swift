//
//  TermsVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 1/29/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class TermsVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var contentLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        self.navigationController?.navigationBar.addCornerRadius(cornerRadius: 25)
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        scrollView.addBorder()
        scrollView.addCornerRadius(cornerRadius: 20)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toMain", sender: self)
    }
}
