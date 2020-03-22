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
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var FromView: UIView!
    @IBOutlet weak var fromTxtField: UITextField!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var toTxtField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var categoryBtn: UIButton!
    @IBOutlet weak var cityBtn: UIButton!
    
    //Variables
    var sTitle: String = " "
    var categoryId: String = " "
    var cityId: String = " "
    var priceFrom: String = " "
    var priceTo: String = " "
    static var categoryName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        categoryBtn.setTitle(SearchVC.categoryName, for: .normal)
        cityBtn.setTitle(AdvertiseNowVC.selectedCountry, for: .normal)
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
        searchTxtField.delegate = self
        fromTxtField.delegate = self
        toTxtField.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSearchResultVC" {
            let destVC = segue.destination as! SearchResultVC
            destVC.sTitle = self.sTitle
            destVC.cityId = self.cityId
            destVC.priceFrom = self.priceFrom
            destVC.priceTo = self.priceTo
        }
    }
    
    @IBAction func categoryBtnPressed(_ sender: Any) {
        let searchCategoryList = SearchCategoryList()
        searchCategoryList.modalPresentationStyle = .fullScreen
        searchCategoryList.modalTransitionStyle = .crossDissolve
        present(searchCategoryList, animated: true, completion: nil)
    }
    
    @IBAction func cityBtnPressed(_ sender: Any) {
        let countryList = CountryListVC()
        countryList.modalPresentationStyle = .fullScreen
        countryList.modalTransitionStyle = .crossDissolve
        present(countryList, animated: true, completion: nil)
    }
    
    
    
    @IBAction func searchBtnPressed(_ sender: Any) {
        if self.searchTxtField.text == "" && self.categoryBtn.titleLabel?.text == "" && self.cityBtn.titleLabel?.text == "" && self.fromTxtField.text == "" && self.toTxtField.text == "" { return }
        else {
            self.sTitle = searchTxtField.text ?? " "
            self.priceFrom = fromTxtField.text ?? " "
            self.priceTo = toTxtField.text ?? " "
            self.performSegue(withIdentifier: "toSearchResultVC", sender: self)
        }
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
