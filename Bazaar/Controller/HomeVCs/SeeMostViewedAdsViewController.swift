//
//  SeeMostViewedAdsViewController.swift
//  Bazaar
//
//  Created by Amal Elgalant on 28/12/2020.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//


import UIKit
import MOLH
import NVActivityIndicatorView
import SDWebImage
class SeeMostViewedAdsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    //Variables
    var allAdsArr = [Ad]()
    var selectedAdId: Int = 0
    var selectedAd = Ad()
    
    //Constants
    let MainAdsCellID = "MainAdsCell"
    var page = 1
    var isTheLastPage = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        // Do any additional setup after loading the view.
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
        
        
        collectionView.register(UINib(nibName: "CustomSliderAdCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomSliderAdCollectionViewCell")
    }
    func loadData() {
        AdsService.instance.getmostViewedAds (page: page){ (error, allAds) in
            //                self.allAdsArr = allAds
            //                self.collectionView.reloadData()
            //                self.indicator.stopAnimating()
            //                self.indicator.isHidden = true
            //            }
            
            if error == nil{
                if allAds!.count == 0{
                    self.isTheLastPage = true
                    self.page = self.page - 1
                }
                else if self.page == 1 && allAds?.count != 0{
                    self.allAdsArr = allAds!
                }
                else{
                    self.allAdsArr.append(contentsOf: allAds!)
                }
            }
            else{
                self.allAdsArr = allAds!
                self.page = 1
            }
            self.collectionView.reloadData()
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension SeeMostViewedAdsViewController: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allAdsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(allAdsArr[indexPath.row].isDefalut)

        if indexPath.row == 0 || allAdsArr[indexPath.row].isDefalut{
            print(indexPath.row)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAdsCellID, for: indexPath) as! MainAdsCell
            
            cell.imgView.sd_setImage(with: URL(string: allAdsArr[indexPath.row].imgUrl), placeholderImage: #imageLiteral(resourceName: "learning"))
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                cell.titleLbl.text = allAdsArr[indexPath.row].titleAr
//                cell.currencyLbl.text = allAdsArr[indexPath.row].cur
                cell.contentLbl.text = allAdsArr[indexPath.row].governrateAR
                
                
            } else {
                cell.titleLbl.text = allAdsArr[indexPath.row].titleEn
//                cell.currencyLbl.text = allAdsArr[indexPath.row].curEn
                cell.contentLbl.text = allAdsArr[indexPath.row].governrateEN
                
                
            }
//            cell.priceLbl.text = "\(allAdsArr[indexPath.row].price)"
//            //        if allAdsArr[indexPath.row].isLoved == true {
//            //             cell.likeImg.image = UIImage(named: "likeR")
//            //         }
//            cell.btnPressed = { [weak self] in
//                if NetworkHelper.getToken() != nil {
//                    AdsService.instance.favoriteAdById(Id: (self?.allAdsArr[indexPath.row].id)!) { (success) in
//                        if success {
//                            //                        if cell.likeImg.image == UIImage(named: "likeR") {
//                            //                            cell.likeImg.image = UIImage(named: "likeG")
//                            //                        } else {
//                            //                        cell.likeImg.image = UIImage(named: "likeR")
//                            //                        }
//                            
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
        else{
            print("hi baby")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomSliderAdCollectionViewCell", for: indexPath) as! CustomSliderAdCollectionViewCell
            cell.setData(ad: allAdsArr[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 || allAdsArr[indexPath.row].isDefalut{
            print(indexPath.row)
            return CGSize(width: 180, height: 220)
        }else{
            print("jjjjjj\(indexPath.row)")

            return CGSize(width: collectionView.bounds.width , height: 220)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 ||  allAdsArr[indexPath.row].isDefalut{
            
            self.selectedAdId = allAdsArr[indexPath.row].id
            performSegue(withIdentifier: "toAdVC", sender: self)
        }else{
            if allAdsArr.count > 0 {
               
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "slider_data") as! SliderAdDetailsViewController
                vc.ad = allAdsArr[indexPath.row]
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastElement = allAdsArr.count - 1
        if !isTheLastPage{
            if indexPath.row == lastElement {
                self.page = page + 1
                loadData()
            }
        }
        
    }
}
