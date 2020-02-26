//
//  SubCategoryListVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/26/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH

class SubCategoryListVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    var selectedCatId: Int = 0
    var selectedSubCatId: Int = 0
    var subcategories = [SubCategory]()
    
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
        CategoriesService.instance.getSubCategoriesAndAdsById(id: selectedCatId) { (error, catId, catNameAr, catNameEn, subcategories, ads) in
            if let subcategories = subcategories {
                self.subcategories = subcategories
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSubSubCatList" {
            let destVC = segue.destination as! SubSubCategoryListVC
            destVC.selectedSubCatId = self.selectedSubCatId
        }
    }
}

extension SubCategoryListVC: UITableViewDelegate, UITableViewDataSource {
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedSubCatId = subcategories[indexPath.row].id
        AdvertiseNowVC.subCatId = subcategories[indexPath.row].id
        AdvertiseNowVC.subCatTitleAr = subcategories[indexPath.row].nameAr
        AdvertiseNowVC.subCatTitleEn = subcategories[indexPath.row].nameEn
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
//        self.navigationController?.pushViewController(UIViewController(nibName: "AdvertiseNowVC", bundle: nil), animated: true)
//        performSegue(withIdentifier: "toAdvertiseNowVC", sender: self)
    }
}
