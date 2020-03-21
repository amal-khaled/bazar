//
//  SubCategoryList.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/26/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH

class SubCategoryList: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var subCategoryLbl: UILabel!
    
    //Variables
    var selectedCatId: Int = 0
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
            subCategoryLbl.text = AdvertiseNowVC.catTitleAr
        } else {
            subCategoryLbl.text = AdvertiseNowVC.catTitleEn
        }
    }
    
    func loadData() {
        CategoriesService.instance.getSubCategoriesById(id: selectedCatId) { (error
            , subcategories) in
            if let subcategories = subcategories {
                self.subcategories = subcategories
                self.tableView.reloadData()
            }
        }
    }
}

extension SubCategoryList: UITableViewDelegate, UITableViewDataSource {
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
            AdvertiseNowVC.subCatId = self?.subcategories[indexPath.row].id ?? 0
            AdvertiseNowVC.subCatTitleAr = self?.subcategories[indexPath.row].nameAr ?? ""
            AdvertiseNowVC.subCatTitleEn = self?.subcategories[indexPath.row].nameEn ?? ""
            let subSubCategoryList = SubSubCategoryList()
            subSubCategoryList.selectedSubCatId = self?.subcategories[indexPath.row].id ?? 0
            subSubCategoryList.modalPresentationStyle = .custom
            subSubCategoryList.modalTransitionStyle = .crossDissolve
            self?.present(subSubCategoryList, animated: true, completion: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CountryCell
        cell.countryBtn.setImage(UIImage(named: "checked_rectangle"), for: .normal)
        AdvertiseNowVC.subCatId = subcategories[indexPath.row].id
        AdvertiseNowVC.subCatTitleAr = subcategories[indexPath.row].nameAr
        AdvertiseNowVC.subCatTitleEn = subcategories[indexPath.row].nameEn
        let subSubCategoryList = SubSubCategoryList()
        subSubCategoryList.selectedSubCatId = subcategories[indexPath.row].id
        subSubCategoryList.modalPresentationStyle = .custom
        subSubCategoryList.modalTransitionStyle = .crossDissolve
        present(subSubCategoryList, animated: true, completion: nil)
    }
}
