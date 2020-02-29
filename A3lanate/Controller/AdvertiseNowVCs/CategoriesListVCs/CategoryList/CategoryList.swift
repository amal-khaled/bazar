//
//  CategoryList.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/26/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH

class CategoryList: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    var categories = [Category]()
    var selectedCatId: Int = 0
    
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
    }
    
    func setupView() {
        tableView.addBorder()
        tableView.addCornerRadius(cornerRadius: 30)
    }
    
    func loadData() {
        CategoriesService.instance.getAllCategoriesWithSubCategoriesAndSomeAds { (error, categories) in
            if let categories = categories {
                self.categories = categories
                self.tableView.reloadData()
            }
        }
    }
}

extension CategoryList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryCellId, for: indexPath) as! CountryCell
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            cell.countryBtn.setTitle(categories[indexPath.row].nameAr, for: .normal)
        } else {
            cell.countryBtn.setTitle(categories[indexPath.row].nameEn, for: .normal)
        }
        cell.btnPressed = { [weak self] in
            cell.countryBtn.setImage(UIImage(named: "checked_rectangle"), for: .normal)
            self?.selectedCatId = self?.categories[indexPath.row].id ?? 0
            AdvertiseNowVC.catId = self?.categories[indexPath.row].id ?? 0
            AdvertiseNowVC.catTitleAr = self?.categories[indexPath.row].nameAr ?? ""
            AdvertiseNowVC.catTitleEn = self?.categories[indexPath.row].nameEn ?? ""
            let subCategoryList = SubCategoryList()
            subCategoryList.selectedCatId = self?.categories[indexPath.row].id ?? 0
            subCategoryList.modalPresentationStyle = .custom
            subCategoryList.modalTransitionStyle = .crossDissolve
            self?.present(subCategoryList, animated: true, completion: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CountryCell
        cell.countryBtn.setImage(UIImage(named: "checked_rectangle"), for: .normal)
        self.selectedCatId = categories[indexPath.row].id
        AdvertiseNowVC.catId = categories[indexPath.row].id
        AdvertiseNowVC.catTitleAr = categories[indexPath.row].nameAr
        AdvertiseNowVC.catTitleEn = categories[indexPath.row].nameEn
        let subCategoryList = SubCategoryList()
        subCategoryList.selectedCatId = categories[indexPath.row].id
        subCategoryList.modalPresentationStyle = .custom
        subCategoryList.modalTransitionStyle = .crossDissolve
        present(subCategoryList, animated: true, completion: nil)
    }
}
