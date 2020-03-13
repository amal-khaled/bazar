//
//  AllOffersVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/8/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import MOLH

class AllOffersVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Variables
    var allAdsArr = [Ad]()
    
    //Constants
    let MainAdsCellID = "MainAdsCell"
    
    
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
        collectionView.register(UINib(nibName: MainAdsCellID, bundle: nil), forCellWithReuseIdentifier: MainAdsCellID)
    }
    
    func loadData() {
        AdsService.instance.getAll { (error, allAds) in
            if let allAds = allAds {
                self.allAdsArr = allAds
                self.collectionView.reloadData()
            }
        }
    }
}

extension AllOffersVC: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allAdsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAdsCellID, for: indexPath) as! MainAdsCell
        Alamofire.request(allAdsArr[indexPath.row].imgUrl).responseImage { (response) in
            if let image = response.result.value {
                DispatchQueue.main.async {
                    cell.imgView.image = image
                }
            }
        }
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            cell.typeLbl.text = allAdsArr[indexPath.row].titleAr
        } else {
            cell.typeLbl.text = allAdsArr[indexPath.row].titleEn
        }
        cell.priceLbl.text = "\(allAdsArr[indexPath.row].price)"
        if allAdsArr[indexPath.row].isLoved == true {
             cell.likeImg.image = UIImage(named: "likeR")
         }
        cell.btnPressed = { [weak self] in
            AdsService.instance.favoriteAdById(Id: (self?.allAdsArr[indexPath.row].id)!) { (success) in
                if success {
                    if cell.likeImg.image == UIImage(named: "likeR") {
                        cell.likeImg.image = UIImage(named: "likeG")
                    } else {
                    cell.likeImg.image = UIImage(named: "likeR")
                    }

                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toAdVC", sender: self)
    }
}
