//
//  CategoryVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/7/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH
import AlamofireImage
import Alamofire


class SubSubCategoryVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Constants
    let MainAdsCelId = "MainAdsCell"
    
    //Variables
    var selectedSubCatId: Int = 0
    var ads = [Ad]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
            cell.typeLbl.text = ads[indexPath.row].titleAr
        } else {
            cell.typeLbl.text = ads[indexPath.row].titleEn
        }
        cell.priceLbl.text = "\(ads[indexPath.row].price)"
        if ads[indexPath.row].isLoved == true {
            cell.likeImg.image = UIImage(named: "likeR")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 180)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toAdVC", sender: self)
    }
}
