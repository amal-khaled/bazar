//
//  CategoryVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH
import AlamofireImage
import Alamofire
import NVActivityIndicatorView


class SubSubCategoryVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    //Constants
    let MainAdsCelId = "MainAdsCell"
    
    //Variables
    var selectedSubCatId: Int = 0
    var ads = [Ad]()
    var selectedAdId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.indicator.startAnimating()
        loadData()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: MainAdsCelId, bundle: nil), forCellWithReuseIdentifier: MainAdsCelId)
    }
    
    func loadData() {
        CategoriesService.instance.getSubSubCategoriesAndAdsById(id: selectedSubCatId) { (error, catId, catNameAr, catNameEn, ads) in
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                self.title = catNameAr
            } else {
                self.title = catNameEn
            }
            if let ads = ads {
                self.ads = ads
                self.collectionView.reloadData()
            }
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAdVC" {
            let destVC = segue.destination as! AdVC
            destVC.selectedAdId = self.selectedAdId
        }
    }
}

extension SubSubCategoryVC: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
//            cell.currencyLbl.text = ads[indexPath.row].cur
            cell.contentLbl.text = ads[indexPath.row].governrateAR


        } else {
            cell.titleLbl.text = ads[indexPath.row].titleEn
//            cell.currencyLbl.text = ads[indexPath.row].curEn
            cell.contentLbl.text = ads[indexPath.row].governrateEN


        }
//        cell.priceLbl.text = "\(ads[indexPath.row].price)"
////        if ads[indexPath.row].isLoved == true {
////            cell.likeImg.image = UIImage(named: "likeR")
////        }
//        if ads[indexPath.row].Featured{
//            cell.isfeaturesIcon.isHidden = false
//        }
//        else{
//            cell.isfeaturesIcon.isHidden = true
//            
//        }
//        cell.btnPressed = { [weak self] in
//            if NetworkHelper.getToken() != nil {
//            AdsService.instance.favoriteAdById(Id: (self?.ads[indexPath.row].id)!) { (success) in
//                if success {
////                    if cell.likeImg.image == UIImage(named: "likeR") {
////                        cell.likeImg.image = UIImage(named: "likeG")
////                    } else {
////                    cell.likeImg.image = UIImage(named: "likeR")
////                    }
//                }
//            }
//            } else {
//                let alert = UIAlertController(title: "", message: "You Should login first".localized, preferredStyle: .alert)
//                self?.present(alert, animated: true, completion: nil)
//                let when = DispatchTime.now() + 2
//                DispatchQueue.main.asyncAfter(deadline: when){
//                    alert.dismiss(animated: true, completion: nil)
//                }
//            }
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size: CGFloat = 220
        if StaticFunctions.getCurrentDevice() == "iPad"{
            size = (self.collectionView.bounds.width / 3) - 10
            return CGSize(width: size, height: 280)


        }else{
         size = (self.collectionView.bounds.width / 2) - 10
            return CGSize(width: size, height: 220)

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedAdId = ads[indexPath.row].id
        performSegue(withIdentifier: "toAdVC", sender: self)
    }
}
