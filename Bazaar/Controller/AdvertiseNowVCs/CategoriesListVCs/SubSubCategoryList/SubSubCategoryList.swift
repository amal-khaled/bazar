//
//  SubSubCategoryList.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH

class SubSubCategoryList: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var subsubCategoryLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    
    //Variables
    var selectedSubCatId: Int = 0
    var subcategories = [SubCategory]()
    
    //Constants
    let CountryCellId = "CountryCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
        loadData()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: CountryCellId, bundle: nil), forCellReuseIdentifier: CountryCellId)
        self.upperView.addCornerRadius(cornerRadius: 25)
        self.upperView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
    }
    
    func setupView() {
        tableView.addBorder()
        tableView.addCornerRadius(cornerRadius: 30)
        if MOLHLanguage.isArabic() {
            subsubCategoryLbl.text = AdvertiseNowVC.subCatTitleAr
        } else {
            subsubCategoryLbl.text = AdvertiseNowVC.subCatTitleEn
        }
    }
    
    func loadData() {
        CategoriesService.instance.getSubCategoriesAndAdsById(id: selectedSubCatId) { (error, catId, catNameAr, catNameEn, subcategories, ads) in
            if let subcategories = subcategories {
                self.subcategories = subcategories
                self.tableView.reloadData()
                if subcategories.count == 0 {
                    AdvertiseNowVC.subSubCatId = 0
                    AdvertiseNowVC.subSubCatTitleAr = ""
                    AdvertiseNowVC.subSubCatTitleEn = ""
                    self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension SubSubCategoryList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subcategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryCellId, for: indexPath) as! CountryCell
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            cell.countryBtn.setTitle(subcategories[indexPath.row].nameAr, for: .normal)
        } else {
            cell.countryBtn.setTitle(subcategories[indexPath.row].nameEn, for: .normal)
        }
        cell.btnPressed = { [weak self] in
            cell.countryBtn.setImage(UIImage(named: "checked_rectangle"), for: .normal)
            self?.selectedSubCatId = self?.subcategories[indexPath.row].id ?? 0
            AdvertiseNowVC.subSubCatId = self?.subcategories[indexPath.row].id ?? 0
            AdvertiseNowVC.subSubCatTitleAr = self?.subcategories[indexPath.row].nameAr ?? ""
            AdvertiseNowVC.subSubCatTitleEn = self?.subcategories[indexPath.row].nameEn ?? ""
            self?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CountryCell
        cell.countryBtn.setImage(UIImage(named: "checked_rectangle"), for: .normal)
        self.selectedSubCatId = subcategories[indexPath.row].id
        AdvertiseNowVC.subSubCatId = subcategories[indexPath.row].id
        AdvertiseNowVC.subSubCatTitleAr = subcategories[indexPath.row].nameAr
        AdvertiseNowVC.subSubCatTitleEn = subcategories[indexPath.row].nameEn
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
