//
//  AdVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import Alamofire
import MOLH
import NVActivityIndicatorView

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
    @IBOutlet weak var featuredAdLbl: UILabel!
    @IBOutlet weak var mainImgBtn: UIButton!
    @IBOutlet weak var reportBtn: LocalizedButton!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    
    //Constants
    let ImageCellId = "ImageCell"
    
    //Variables
    var selectedAdId: Int = 0
    var images = [String]()
    var features = [Feature]()
    var userAds = [Ad]()
    var similarAds = [Ad]()
    var adPhone: String = ""
    var shareLink: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        setupCollectionView()
        setupView()
        loadData()
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
    
    func setupView() {
        featuredAdLbl.isHidden = true
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
                if ad.AdWithoutPhone == false {
                    self.adPhone = ad.PhoneNumber
                }
                self.shareLink = ad.ShareLink
                if ad.Featured == true {
                    self.featuredAdLbl.isHidden = false
                }
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
        indicator.stopAnimating()
        indicator.isHidden = true
    }
    
    @IBAction func whatsAppBtnPressed(_ sender: Any) {
        if adPhone == "" {
            let alert = UIAlertController(title: "", message: "There is no whatsapp for this ad".localized, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 3
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }
        else {
            let urlWhats = "https://wa.me/\(adPhone)"
            if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
                if let whatsappURL = URL(string: urlString) {
                    if UIApplication.shared.canOpenURL(whatsappURL){
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(whatsappURL)
                        }
                    }
                    else {
                        
                    }
                }
            }
            
        }
    }
    
    @IBAction func likeBtnPressed(_ sender: Any) {
        if NetworkHelper.getToken() != nil {
            AdsService.instance.favoriteAdById(Id: self.selectedAdId) { (success) in
                if success {
                    if self.likeBtn.imageView?.image == UIImage(named: "likeR") {
                        self.likeBtn.setImage(UIImage(named: "likeG"), for: .normal)
                    } else {
                        self.likeBtn.setImage(UIImage(named: "likeR"), for: .normal)
                    }

                }
            }
        } else {
            let alert = UIAlertController(title: "", message: "You Should login first".localized, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 3
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func callBtnPressed(_ sender: Any) {
        if adPhone == "" {
            let alert = UIAlertController(title: "", message: "There is no number for this ad".localized, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 3
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }
        else {
            if let url = NSURL(string: "tel://\(adPhone)"), UIApplication.shared.canOpenURL(url as URL) {
              UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func locationBtnPressed(_ sender: Any) {
    }
    
    @IBAction func shareBtnPressed(_ sender: Any) {
        let text = "Check this ad: ".localized + "\(shareLink)\n" + "Download the app from this link: ".localized + "https://apple.co/3beivtw"
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func followUpBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toFollowUpVC", sender: self)
    }
    
    @IBAction func mainImgBtnPressed(_ sender: Any) {
        let imageDisplayVC = ImageDisplayVC()
        imageDisplayVC.imgUrl = images[0]
        imageDisplayVC.modalPresentationStyle = .custom
        imageDisplayVC.modalTransitionStyle = .crossDissolve
        present(imageDisplayVC, animated: true, completion: nil)
    }
    
    @IBAction func reportBtnPressed(_ sender: Any) {
        let adReportVC = AdReportVC()
        adReportVC.adId = self.selectedAdId
        adReportVC.modalPresentationStyle = .custom
        adReportVC.modalTransitionStyle = .crossDissolve
        present(adReportVC, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFollowUpVC" {
            let destVC = segue.destination as! FollowUpVC
            destVC.selectedAdId = self.selectedAdId
        }
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
            return cell
        }
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCellId, for: indexPath) as! ImageCell
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
        if collectionView.tag == 0 {
            let imageDisplayVC = ImageDisplayVC()
            imageDisplayVC.imgUrl = images[indexPath.row]
            imageDisplayVC.modalPresentationStyle = .custom
            imageDisplayVC.modalTransitionStyle = .crossDissolve
            present(imageDisplayVC, animated: true, completion: nil)
        }
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
