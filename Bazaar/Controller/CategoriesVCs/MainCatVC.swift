//
//  MainCatVC.swift
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

class MainCatVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var subSubCategoryCollection: UICollectionView!
    @IBOutlet weak var subCategoryCollection: UICollectionView!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    //Constants
    let SubSubCategoryCellId = "SubSubCategoryCell"
    let MainAdsCelId = "MainAdsCell"
    
    //Variables
    var subCategories = [SubCategory]()
    var ads = [Ad]()
    var selectedSubCatId: Int = 0
    var selectedAdId: Int = 0
    var selectedMainCatId: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        indicator.startAnimating()
        loadData()
    }
    
    func setupView() {
        
    }
    
    func setupCollectionView() {
        subCategoryCollection.delegate = self
        subSubCategoryCollection.delegate = self
        subCategoryCollection.dataSource = self
        subSubCategoryCollection.dataSource = self
        subSubCategoryCollection.register(UINib(nibName: SubSubCategoryCellId, bundle: nil), forCellWithReuseIdentifier: SubSubCategoryCellId)
        subCategoryCollection.register(UINib(nibName: MainAdsCelId, bundle: nil), forCellWithReuseIdentifier: MainAdsCelId)
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
                self.subSubCategoryCollection.reloadData()
            }
            if let ads = ads {
                self.ads = ads
                self.subCategoryCollection.reloadData()
            }
        }
        indicator.stopAnimating()
        indicator.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSubCategoryVC" {
            let destVC = segue.destination as! SubCategoryVC
            destVC.selectedCatId = self.selectedSubCatId
        }
        
        if segue.identifier == "toAdVC" {
            let destVC = segue.destination as! AdVC
            destVC.selectedAdId = self.selectedAdId
        }
    }
}


extension MainCatVC: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
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
            return 1
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
//            
//            cell.btnPressed = { [weak self] in
//                if NetworkHelper.getToken() != nil {
//                    AdsService.instance.favoriteAdById(Id: (self?.ads[indexPath.row].id)!) { (success) in
//                        if success {
////                            if cell.likeImg.image == UIImage(named: "likeR") {
////                                cell.likeImg.image = UIImage(named: "likeG")
////                            } else {
////                                cell.likeImg.image = UIImage(named: "likeR")
////                            }
//                        }
//                    }
//                } else {
//                    let alert = UIAlertController(title: "", message: "You Should login first".localized, preferredStyle: .alert)
//                    self?.present(alert, animated: true, completion: nil)
//                    let when = DispatchTime.now() + 2
//                    DispatchQueue.main.asyncAfter(deadline: when){
//                        alert.dismiss(animated: true, completion: nil)
//                    }
//                }
//            }
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAdsCelId, for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: 170, height: 60)
        }
        if collectionView.tag == 2 {
            var size: CGFloat = 220
            if StaticFunctions.getCurrentDevice() == "iPad"{
                size = (collectionView.bounds.width / 3) - 10
                return CGSize(width: size, height: 280)


            }else{
             size = (collectionView.bounds.width / 2) - 10
                return CGSize(width: size, height: 220)

            }
        }
        else {
            var size: CGFloat = 220
            if StaticFunctions.getCurrentDevice() == "iPad"{
                size = (collectionView.bounds.width / 3) - 10
                return CGSize(width: size, height: 280)


            }else{
             size = (collectionView.bounds.width / 2) - 10
                return CGSize(width: size, height: 220)

            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            self.selectedSubCatId = subCategories[indexPath.row].id
            performSegue(withIdentifier: "toSubCategoryVC", sender: self)
        }
        if collectionView.tag == 2 {
            self.selectedAdId = ads[indexPath.row].id
            performSegue(withIdentifier: "toAdVC", sender: self)
        }
    }
}
