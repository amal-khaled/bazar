//
//  SearchResultVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import MOLH
import NVActivityIndicatorView

class SearchResultVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    //Variables
    var ads = [Ad]()
    var sTitle: String = " "
    static var categoryId: String = " "
    var cityId: String = " "
    var priceFrom: String = " "
    var priceTo: String = " "
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
        let parameters: [String : Any] = [
            "Title": sTitle,
            "CategoryId": SearchResultVC.categoryId,
            "CityId": 1,
            "PriceFrom": priceFrom,
            "PriceTo": priceTo
        ]
        
        print(parameters)
        print(SEARCH_URL)

        Alamofire.request(SEARCH_URL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            print(response.result.value)

            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let value):
                let json = JSON(value)
                var all = [Ad]()
                if let allArr = json.array {
                    for item in allArr {
                        guard let item = item.dictionary else {return}
                        let ad = Ad()
                        ad.id = item["AdId"]?.int ?? 0
                        ad.titleAr = item["Title"]?.string ?? ""
                        ad.titleEn = item["TitleEN"]?.string ?? ""
                        ad.imgUrl = item["FileBank"]?["FileURL"].string ?? ""
                        ad.price = item["AdPrice"]?.double ?? 0.0
                        ad.StatusId = item["StatusId"]?.int ?? 0
                        ad.governrateAR = item["GovernerateAR"]?.string ?? ""
                        ad.governrateEN = item["GovernerateEN"]?.string ?? ""
                        if let _cur = item["Currency"]?.string{
                            ad.cur = _cur
                            ad.curEn = (item["CurrencyEN"]?.string) ?? ""
                        }
                        all.append(ad)
                    }
                }
                self.ads = all
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

extension SearchResultVC: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAdsCellID, for: indexPath) as! MainAdsCell
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
//        if ads[indexPath.row].isLoved == true {
//            cell.likeImg.image = UIImage(named: "likeR")
//        }
//        cell.btnPressed = { [weak self] in
//            if NetworkHelper.getToken() != nil {
//                AdsService.instance.favoriteAdById(Id: (self?.ads[indexPath.row].id)!) { (success) in
//                    if success {
////                        if cell.likeImg.image == UIImage(named: "likeR") {
////                            cell.likeImg.image = UIImage(named: "likeG")
////                        } else {
////                            cell.likeImg.image = UIImage(named: "likeR")
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
