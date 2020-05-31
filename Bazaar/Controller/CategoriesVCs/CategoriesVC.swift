//
//  CategoriesVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH
import NVActivityIndicatorView

class CategoriesVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    
    //Constants
    let CategoryCellId = "CategoryCell"
    
    //Variables
    var categories = [Category]()
    var selectedAdId: Int = 0
    var selectedCatId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        indicator.startAnimating()
        loadData()
        setupTableView()
    }
    
    func setupView() {
        self.navigationController?.navigationBar.addCornerRadius(cornerRadius: 25)
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        self.tabBarController?.tabBar.addCornerRadius(cornerRadius: 25)
        self.tabBarController?.tabBar.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: CategoryCellId, bundle: nil), forCellReuseIdentifier: CategoryCellId)
    }
    
    func loadData() {
        CategoriesService.instance.getAllCategoriesWithSubCategoriesAndSomeAds { (error, categories) in
            if let categories = categories {
                self.categories = categories
                self.tableView.reloadData()
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSubCategoryVC" {
            let destVC = segue.destination as! SubCategoryVC
            destVC.selectedCatId = self.selectedCatId
        }
        
        if segue.identifier == "toAdVC" {
            let destVC = segue.destination as! AdVC
            destVC.selectedAdId = self.selectedAdId
        }
    }
}

extension CategoriesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCellId, for: indexPath) as! CategoryCell
        cell.parent = self
        cell.ads = categories[indexPath.row].Ads
        cell.subCategories = categories[indexPath.row].subCategories
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            cell.catNameLbl.text = categories[indexPath.row].nameAr
        } else {
            cell.catNameLbl.text = categories[indexPath.row].nameEn
        }
        return cell
    }
}
