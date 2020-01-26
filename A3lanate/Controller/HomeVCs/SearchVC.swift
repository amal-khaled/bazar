//
//  SearchVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 1/23/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var categoryTxtField: UITextField!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var locationTxtField: UITextField!
    @IBOutlet weak var FromView: UIView!
    @IBOutlet weak var fromTxtField: UITextField!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var toTxtField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
         setupView()
    }
    
    func setupView() {
        self.navigationController?.navigationBar.addCornerRadius(cornerRadius: 25)
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        self.tabBarController?.tabBar.addCornerRadius(cornerRadius: 25)
        self.tabBarController?.tabBar.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        firstView.addCornerRadius(cornerRadius: 25)
        secondView.addCornerRadius(cornerRadius: 25)
        thirdView.addCornerRadius(cornerRadius: 25)
        FromView.addCornerRadius(cornerRadius: 25)
        toView.addCornerRadius(cornerRadius: 25)
        searchBtn.addCornerRadius(cornerRadius: 25)
        firstView.addBorder()
        secondView.addBorder()
        thirdView.addBorder()
        FromView.addBorder()
        toView.addBorder()
    }
    
    @IBAction func searchBtnPressed(_ sender: Any) {
    }
}
