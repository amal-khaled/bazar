//
//  AllOffersVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import MOLH
import NVActivityIndicatorView

class AllOffersVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    //Variables
    var allAdsArr = [Ad]()
    var selectedAdId: Int = 0
    
    //Constants
    let MainAdsCellID = "MainAdsCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        indicator.startAnimating()
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
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAdVC" {
            let destVC = segue.destination as! AdVC
            destVC.selectedAdId = self.selectedAdId
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
            cell.titleLbl.text = allAdsArr[indexPath.row].titleAr
//            cell.currencyLbl.text = allAdsArr[indexPath.row].cur
            cell.contentLbl.text = allAdsArr[indexPath.row].governrateAR

        } else {
            cell.titleLbl.text = allAdsArr[indexPath.row].titleEn
//            cell.currencyLbl.text = allAdsArr[indexPath.row].curEn
            cell.contentLbl.text = allAdsArr[indexPath.row].governrateEN


        }
//        cell.priceLbl.text = "\(allAdsArr[indexPath.row].price)"
//        if allAdsArr[indexPath.row].isLoved == true {
//             cell.likeImg.image = UIImage(named: "likeR")
//         }
//        cell.btnPressed = { [weak self] in
//            if NetworkHelper.getToken() != nil {
//                AdsService.instance.favoriteAdById(Id: (self?.allAdsArr[indexPath.row].id)!) { (success) in
//                    if success {
////                        if cell.likeImg.image == UIImage(named: "likeR") {
////                            cell.likeImg.image = UIImage(named: "likeG")
////                        } else {
////                        cell.likeImg.image = UIImage(named: "likeR")
////                        }
//
//                    }
//                }
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
        return CGSize(width: 180, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedAdId = allAdsArr[indexPath.row].id
        performSegue(withIdentifier: "toAdVC", sender: self)
    }
}
