//
//  SubCategoryVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH
import Alamofire
import AlamofireImage
import NVActivityIndicatorView

class SubCategoryVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var subSubCategoryCollection: UICollectionView!
//    @IBOutlet weak var subCategoryCollection: UICollectionView!
    @IBOutlet weak var secondCategoryCollectionView: UICollectionView!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    //Constants
    let SubSubCategoryCellId = "SubSubCategoryCell"
    let MainAdsCelId = "MainAdsCell"
    
    //Variables
    var selectedCatId: Int = 0
    var subCategories = [SubCategory]()
    var secondSubCategories = [SubCategory]()

    var ads = [Ad]()
    var selectedSubCatId: Int = 0
    var selectedAdId: Int = 0
    var selectedMainCatId: Int = 0
    
    var selectedCategoryIndex = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        setupCollectionView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.indicator.startAnimating()
        loadData()
    }
    
    func setupView() {
        
    }
    
    func setupCollectionView() {
//        subCategoryCollection.delegate = self
        subSubCategoryCollection.delegate = self
//        subCategoryCollection.dataSource = self
        subSubCategoryCollection.dataSource = self
        subSubCategoryCollection.register(UINib(nibName: SubSubCategoryCellId, bundle: nil), forCellWithReuseIdentifier: SubSubCategoryCellId)
//        subCategoryCollection.register(UINib(nibName: MainAdsCelId, bundle: nil), forCellWithReuseIdentifier: MainAdsCelId)
        
        secondCategoryCollectionView.delegate = self
//        subCategoryCollection.dataSource = self
        secondCategoryCollectionView.dataSource = self
        secondCategoryCollectionView.register(UINib(nibName: SubSubCategoryCellId, bundle: nil), forCellWithReuseIdentifier: SubSubCategoryCellId)
    }

    func loadData() {
            CategoriesService.instance.getCategoriesSubAndAdsById(id: selectedMainCatId) { (error, catId, catNameAr, catNameEn, subcategories, ads) in
                if MOLHLanguage.currentAppleLanguage() == "ar" {
                    self.title = catNameAr
                } else {
                    self.title = catNameEn
                }
                if let subcategories = subcategories {
                    print(subcategories)
                    self.subCategories = subcategories
//                    self.tableView.reloadData()
                    self.subSubCategoryCollection.reloadData()
                    print(self.selectedSubCatId)
                    self.subSubCategoryCollection.selectItem(at: [0,self.selectedCategoryIndex], animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
                    self.loadSubData()

                }
                if let ads = ads {
                    self.ads = ads
                    self.tableView.reloadData()
                }
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
    }
    func loadSubData() {
        CategoriesService.instance.getSubCategoriesAndAdsById(id: selectedCatId) { (error, catId, catNameAr, catNameEn, subcategories, ads) in
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                self.title = catNameAr
            } else {
                self.title = catNameEn
            }
            if let subcategories = subcategories {
                print(subcategories)
                self.secondSubCategories = subcategories
//                    self.tableView.reloadData()
                self.secondCategoryCollectionView.reloadData()
//                if subcategories.count > 0{
//                    self.secondCategoryCollectionView.isHidden = false
//                }else{
//                    self.secondCategoryCollectionView.isHidden = true
//
//                }
                

            }
            if let ads = ads {
//                self.ads = ads
//                self.tableView.reloadData()
            }
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSubSubCatVC" {
            let destVC = segue.destination as! SubSubCategoryVC
            destVC.selectedSubCatId = self.selectedSubCatId
        }
        
        if segue.identifier == "toAdVC" {
            let destVC = segue.destination as! AdVC
            destVC.selectedAdId = self.selectedAdId
        }
    }
}


extension SubCategoryVC: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return subCategories.count
        }
        if collectionView.tag == 2 {
            return ads.count
        }
        else {
           return subCategories.count

        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubSubCategoryCellId, for: indexPath) as! SubSubCategoryCell
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                cell.subcategoryLbl.text = subCategories[indexPath.row].nameAr
            } else {
                cell.subcategoryLbl.text = subCategories[indexPath.row].nameEn
            }
            return cell
        }
        if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAdsCelId, for: indexPath) as! MainAdsCell
            Alamofire.request(ads[indexPath.row].imgUrl).responseImage { (response) in
                if let image = response.result.value {
                    DispatchQueue.main.async {
                        cell.imgView.image = image
                    }
                }
            }
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                cell.titleLbl.text = ads[indexPath.row].titleAr
//                cell.currencyLbl.text = ads[indexPath.row].cur
                cell.contentLbl.text = ads[indexPath.row].governrateAR


            } else {
                cell.titleLbl.text = ads[indexPath.row].titleEn
//                cell.currencyLbl.text = ads[indexPath.row].curEn
                cell.contentLbl.text = ads[indexPath.row].governrateEN


            }
//            if ads[indexPath.row].Featured{
//                cell.isfeaturesIcon.isHidden = false
//            }
//            else{
//                cell.isfeaturesIcon.isHidden = true
//                
//            }
//            cell.priceLbl.text = "\(ads[indexPath.row].price)"
////            if ads[indexPath.row].isLoved == true {
////                cell.likeImg.image = UIImage(named: "likeR")
////            }
//            cell.btnPressed = { [weak self] in
//                if NetworkHelper.getToken() != nil {
//                AdsService.instance.favoriteAdById(Id: (self?.ads[indexPath.row].id)!) { (success) in
//                    if success {
////                        if cell.likeImg.image == UIImage(named: "likeR") {
////                            cell.likeImg.image = UIImage(named: "likeG")
////                        } else {
////                        cell.likeImg.image = UIImage(named: "likeR")
////                        }
//                    }
//                }
//                    } else {
//                        let alert = UIAlertController(title: "", message: "You Should login first".localized, preferredStyle: .alert)
//                        self?.present(alert, animated: true, completion: nil)
//                        let when = DispatchTime.now() + 2
//                        DispatchQueue.main.asyncAfter(deadline: when){
//                            alert.dismiss(animated: true, completion: nil)
//                        }
//                    }
//            }
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubSubCategoryCellId, for: indexPath) as! SubSubCategoryCell
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                cell.subcategoryLbl.text = subCategories[indexPath.row].nameAr
            } else {
                cell.subcategoryLbl.text = subCategories[indexPath.row].nameEn
            }
            return cell
        }
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView.tag == 1 {
//            return CGSize(width: 170, height: 60)
//        }
////        if collectionView.tag == 2 {
////            var size: CGFloat = 220
////            if StaticFunctions.getCurrentDevice() == "iPad"{
////                size = (self.subCategoryCollection.bounds.width / 3) - 10
////                return CGSize(width: size, height: 280)
////
////
////            }else{
////             size = (self.subCategoryCollection.bounds.width / 2) - 10
////                return CGSize(width: size, height: 220)
////
////            }
////        }
//        else {
//            var size: CGFloat = 220
//            if StaticFunctions.getCurrentDevice() == "iPad"{
//                size = (self.subSubCategoryCollection.bounds.width / 3) - 10
//                return CGSize(width: size, height: 280)
//
//
//            }else{
//             size = (self.subSubCategoryCollection.bounds.width / 2) - 10
//                return CGSize(width: size, height: 220)
//
//            }
//        }
//    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            self.selectedSubCatId = subCategories[indexPath.row].id
            loadSubData()
//            performSegue(withIdentifier: "toSubSubCatVC", sender: self)
        }
//        if collectionView.tag == 2 {
//            self.selectedAdId = ads[indexPath.row].id
//            performSegue(withIdentifier: "toAdVC", sender: self)
//        }
    }
}
extension SubCategoryVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoryProductTableViewCell
        cell.setData(ad: ads[indexPath.row])
        return cell
    }
    
    
}
