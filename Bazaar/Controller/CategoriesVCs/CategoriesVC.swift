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
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    @IBOutlet weak var categoryColection: UICollectionView!
    @IBOutlet weak var subCategoryColection: UICollectionView!
    
    
    //Constants
    let CategoryCellId = "CategoryCell"
    
    //Variables
    var categories = [Category]()
    var subcategories = [SubCategory]()
    var selectedsubCatId: Int = 0
    var selectedCatId: Int = 0
    var selectedSubIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        setupView()
        //        indicator.startAnimating()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setStatusBar(backgroundColor: .white )
        
        super.viewWillAppear(true)
        
    }
    
    func setupView() {
        
        self.navigationController?.navigationBar.addCornerRadius(cornerRadius: 25)
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        //        self.tabBarController?.tabBar.addCornerRadius(cornerRadius: 25)
        //        self.tabBarController?.tabBar.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
    }
    
    
    
    func loadData() {
        CategoriesService.instance.getMainCategories { (error, categories) in
            if let categories = categories {
                self.categories = categories
                self.categoryColection.reloadData()

                if self.categories.count > 0{
                    self.selectedCatId = categories[0].id
                    self.categoryColection.selectItem(at: [0,0], animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
                    self.loadSubData()
                }
                print(self.categories.count)
            }
        }
    }
    func loadSubData() {
        CategoriesService.instance.getSubCategoriesById(id: selectedCatId) { (error
                                                                              , subcategories) in
            if let subcategories = subcategories {
                self.subcategories = subcategories
                self.subCategoryColection.reloadData()
                
            }
        }
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "toSubCategoryVC" {
    //            let destVC = segue.destination as! SubCategoryVC
    //            destVC.selectedCatId = self.selectedCatId
    //        }
    //
    //        if segue.identifier == "toAdVC" {
    //            let destVC = segue.destination as! AdVC
    //            destVC.selectedAdId = self.selectedAdId
    //        }
    //    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        if segue.identifier == "toMainCatVC" {
            let destVC = segue.destination as! SubCategoryVC
            destVC.selectedMainCatId = self.selectedCatId
            destVC.selectedCategoryIndex = selectedSubIndex
        }
    }
}

//extension CategoriesVC: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return categories.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCellId, for: indexPath) as! CategoryCell
//        cell.parent = self
//        cell.ads = categories[indexPath.row].Ads
//        cell.subCategories = categories[indexPath.row].subCategories
//        if MOLHLanguage.currentAppleLanguage() == "ar" {
//            cell.catNameLbl.text = categories[indexPath.row].nameAr
//        } else {
//            cell.catNameLbl.text = categories[indexPath.row].nameEn
//        }
//        return cell
//    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//            let lastElement = categories.count - 1
//            if !isTheLast{
//                print(indexPath.row  )
//                print(categories.count-1)
//                if indexPath.row == lastElement {
//                    self.page = page + 1
//                    loadData()
//                }
//            }
//
//    }
//}
extension CategoriesVC : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryColection{
                   print(categories.count)
                   return categories.count
               }else{
                   print(subcategories.count)
       
                   return subcategories.count
               }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryColection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "catCell", for: indexPath) as! SideCategoryCollectionViewCell
            
            cell.setData(category: categories[indexPath.row])
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subCell", for: indexPath) as! SubCategoryCollectionViewCell
            
            cell.setData(category: subcategories[indexPath.row])
            
            return cell
        }
    }
    //     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //        if collectionView == categoryColection{
    //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "catCell", for: indexPath) as! SideCategoryCollectionViewCell
    //
    //            cell.setData(category: categories[indexPath.row])
    //
    //            return cell
    //        }else{
    //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subCell", for: indexPath) as! SubCategoryCollectionViewCell
    //
    //            cell.setData(category: subcategories[indexPath.row])
    //
    //            return cell
    //        }
    //
    //    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryColection{
            self.selectedCatId = categories[indexPath.row].id
            
            loadSubData()
        }else{
            self.selectedsubCatId = subcategories[indexPath.row].id
            self.selectedSubIndex = indexPath.row
            self.performSegue(withIdentifier: "toMainCatVC", sender: self)

        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryColection{
            return CGSize(width: 112, height: 88)
        }else {
            return CGSize(width: collectionView.frame.width/2 - 11, height: 107)
            
            
        }
    }
}
