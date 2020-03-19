//
//  AdVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/9/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import Alamofire
import MOLH

class AdVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var adImg: UIImageView!
    @IBOutlet weak var adPriceLbl: UILabel!
    @IBOutlet weak var adViewsLbl: UILabel!
    @IBOutlet weak var adTitleLbl: UILabel!
    @IBOutlet weak var addTreeLbl: UILabel!
    @IBOutlet weak var whatsAppBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var followUpBtn: UIButton!
    @IBOutlet weak var imagesCollection: UICollectionView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var sameUserAdsCollection: UICollectionView!
    @IBOutlet weak var similarAdsCollection: UICollectionView!
    @IBOutlet weak var downloadAdImg: UIButton!
    
    
    //Constants
    let ImageCellId = "ImageCell"
    
    //Variables
    var selectedAdId: Int = 0
    var images = [String]()
    var features = [Feature]()
    var userAds = [Ad]()
    var similarAds = [Ad]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        loadData()
    }
    
    func setupView() {
        downloadAdImg.backgroundColor = UIColor.white
        downloadAdImg.addCornerRadius(cornerRadius: 20)
    }
    
    func setupCollectionView() {
        imagesCollection.dataSource = self
        imagesCollection.delegate = self
        imagesCollection.register(UINib(nibName: ImageCellId, bundle: nil), forCellWithReuseIdentifier: ImageCellId)
        sameUserAdsCollection.dataSource = self
        sameUserAdsCollection.delegate = self
        sameUserAdsCollection.register(UINib(nibName: ImageCellId, bundle: nil), forCellWithReuseIdentifier: ImageCellId)
        similarAdsCollection.dataSource = self
        similarAdsCollection.delegate = self
        similarAdsCollection.register(UINib(nibName: ImageCellId, bundle: nil), forCellWithReuseIdentifier: ImageCellId)
    }
    
    func loadData() {
        AdsService.instance.getAdById(id: selectedAdId) { (error, ad, images, features, userAds, similarAds) in
            if let ad = ad {
                self.adPriceLbl.text = "\(ad.price)" + " " + "KWD".localized
                self.adViewsLbl.text = "\(ad.AdViews)" + " " + "Views".localized
                if MOLHLanguage.currentAppleLanguage() == "ar" {
                    self.adTitleLbl.text = ad.titleAr
                    self.addTreeLbl.text = ad.CategoryNameAR + "-" + ad.SubCategoryNameAR + "-" + ad.SubSubCategoryNameAR
                    self.descLbl.text = ad.Description
                } else {
                    self.adTitleLbl.text = ad.titleEn
                    self.addTreeLbl.text = ad.CategoryNameEN + "-" + ad.SubCategoryNameEN + "-" + ad.SubSubCategoryNameEN
                    self.descLbl.text = ad.DescriptionEN

                }
                Alamofire.request(ad.CreatedByImageURL).responseImage { (response) in
                    if let image = response.result.value {
                        DispatchQueue.main.async {
                            self.profileImg.image = image
                            self.profileImg.contentMode = .scaleToFill
                        }
                    }
                }
                self.usernameLbl.text = ad.CreatedByName
                self.dateLbl.text = ad.StartDate
            }
            if let images = images {
                self.images = images
                if images.count != 0 {
                    Alamofire.request(images[0]).responseImage { (response) in
                        if let image = response.result.value {
                            DispatchQueue.main.async {
                                self.adImg.image = image
                                self.adImg.contentMode = .scaleToFill
                            }
                        }
                    }
                }
                self.imagesCollection.reloadData()
            }
            if let features = features {
                self.features = features
            }
            if let userAds = userAds {
                self.userAds = userAds
                self.sameUserAdsCollection.reloadData()
            }
            if let similarAds = similarAds {
                self.similarAds = similarAds
                self.similarAdsCollection.reloadData()
            }
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error".localized, message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK".localized, style: .default))
            present(ac, animated: true)
        } else {
       
            let ac = UIAlertController(title: "Saved!".localized, message: "This picture has been saved to your photos.".localized, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK".localized, style: .default))
            present(ac, animated: true)
        }
    }
    
    @IBAction func whatsAppBtnPressed(_ sender: Any) {
    }
    
    @IBAction func likeBtnPressed(_ sender: Any) {
    }
    
    @IBAction func callBtnPressed(_ sender: Any) {
    }
    
    @IBAction func locationBtnPressed(_ sender: Any) {
    }
    
    @IBAction func shareBtnPressed(_ sender: Any) {
    }
    
    @IBAction func followUpBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toFollowUpVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFollowUpVC" {
            let destVC = segue.destination as! FollowUpVC
            destVC.selectedAdId = self.selectedAdId
        }
    }
    
    @IBAction func downloadAdImageBtnPressed(_ sender: Any) {
        let image = self.adImg.image
        UIImageWriteToSavedPhotosAlbum(image!, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
}

extension AdVC: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return self.images.count
        }
        if collectionView.tag == 1 {
            return self.userAds.count
        }
        if collectionView.tag == 2 {
            return self.similarAds.count
        }
        else {
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCellId, for: indexPath) as! ImageCell
            Alamofire.request(images[indexPath.row]).responseImage { (response) in
                if let image = response.result.value {
                    DispatchQueue.main.async {
                        cell.adImg.image = image
                        cell.adImg.contentMode = .scaleToFill
                    }
                }
            }
            cell.btnPressed = { [weak self] in
                let image = cell.adImg.image
                UIImageWriteToSavedPhotosAlbum(image!, self, #selector(self?.image(_:didFinishSavingWithError:contextInfo:)), nil)
            }
            return cell
        }
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCellId, for: indexPath) as! ImageCell
            cell.downloadBtn.isHidden = true
            Alamofire.request(userAds[indexPath.row].imgUrl).responseImage { (response) in
                if let image = response.result.value {
                    DispatchQueue.main.async {
                        cell.adImg.image = image
                        cell.adImg.contentMode = .scaleToFill
                    }
                }
            }
            return cell
        }
        if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCellId, for: indexPath) as! ImageCell
            cell.downloadBtn.isHidden = true
            Alamofire.request(similarAds[indexPath.row].imgUrl).responseImage { (response) in
                if let image = response.result.value {
                    DispatchQueue.main.async {
                        cell.adImg.image = image
                        cell.adImg.contentMode = .scaleToFill
                    }
                }
            }
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCellId, for: indexPath) as! ImageCell
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            return CGSize(width: 150, height: 150)
        }
        if collectionView.tag == 1 {
            return CGSize(width: 120, height: 120)
        }
        if collectionView.tag == 2 {
            return CGSize(width: 120, height: 120)
        }
        else {
            return CGSize(width: 120, height: 120)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView.tag == 0 {
//            let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
//        }
        if collectionView.tag == 1 {
            self.selectedAdId = userAds[indexPath.row].id
            self.loadData()
        }
        if collectionView.tag == 2 {
            self.selectedAdId = similarAds[indexPath.row].id
            self.loadData()
        }
    }
}
