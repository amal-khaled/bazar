//
//  CategoryListVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/26/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH

class CategoryListVC: UIViewController {
    
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
        loadData()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: CountryCellId, bundle: nil), forCellReuseIdentifier: CountryCellId)
    }
    
    func loadData() {
        CategoriesService.instance.getAllCategoriesWithSubCategoriesAndSomeAds { (error, categories) in
            if let categories = categories {
                self.categories = categories
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSubCatList" {
            let destVC = segue.destination as! SubCategoryListVC
            destVC.selectedCatId = self.selectedCatId
        }
    }
}

extension CategoryListVC: UITableViewDelegate, UITableViewDataSource {
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCatId = categories[indexPath.row].id
        AdvertiseNowVC.catId = categories[indexPath.row].id
        AdvertiseNowVC.catTitleAr = categories[indexPath.row].nameAr
        AdvertiseNowVC.catTitleEn = categories[indexPath.row].nameEn
        performSegue(withIdentifier: "toSubCatList", sender: self)
    }
}
