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
import ImageSlideshow

class AdVC: UIViewController {
    @IBOutlet weak var imageSlider: ImageSlideshow!
    
    //Outlets
    @IBOutlet weak var adPriceLbl: UILabel!
    var sliderAlamoSource = [AlamofireSource]()
    var ad = Ad()
    @IBOutlet weak var viewesLbl: UILabel!
    @IBOutlet weak var adViewsLbl: UILabel!
    @IBOutlet weak var adTitleLbl: UILabel!
    @IBOutlet weak var addTreeLbl: UILabel!
    @IBOutlet weak var whatsAppBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var followUpBtn: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var sameUserAdsCollection: UICollectionView!
    @IBOutlet weak var similarAdsCollection: UICollectionView!
    @IBOutlet weak var featuredAdLbl: UILabel!
    @IBOutlet weak var reportBtn: LocalizedButton!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
//    @IBOutlet weak var adByUserViewHight: NSLayoutConstraint!
    @IBOutlet weak var adByUserTitleHight: NSLayoutConstraint!
    @IBOutlet weak var adByUserCollectionHight: NSLayoutConstraint!
    var isAdOwner = false
    //Constants
    let ImageCellId = "ImageCell"
    
    @IBOutlet weak var editRemoveView: UIStackView!
    @IBOutlet weak var removeAdBtn: UIButton!

    //Variables
    var selectedAdId: Int = 0
    var images = [String]()
    var features = [Feature]()
    var userAds = [Ad]()
    var similarAds = [Ad]()
    var adPhone: String = ""
    var shareLink: String = ""
    var isRemoveAdHidden = -1
var stringImages = [ImageUpdate]()
    @IBOutlet weak var editRemoveHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        setupCollectionView()
        setupAllSliders()
//        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        loadData()
        setupView()
        
        if isAdOwner{
            editRemoveHeight.constant = 50
            editRemoveView.isHidden = false
            if isRemoveAdHidden == 0{
                removeAdBtn.isHidden = false
                
                removeAdBtn.setTitle("Remove ad".localized, for: .normal)
            }else if isRemoveAdHidden == 1{
                removeAdBtn.isHidden = false
                removeAdBtn.setTitle("Republish".localized, for: .normal)
            }
            else if isRemoveAdHidden == 2 {
                
                removeAdBtn.isHidden = false
                removeAdBtn.setTitle("Pay Now".localized, for: .normal)
                
            }
            else{
                removeAdBtn.isHidden = true
                
            }
        }else{
            editRemoveView.isHidden = true

            editRemoveHeight.constant = 0

        }
        
    }
    func setupAllSliders(){
        imageSlider.activityIndicator = DefaultActivityIndicator()

        imageSlider.slideshowInterval = 3.0
        imageSlider.contentScaleMode = .scaleToFill
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        imageSlider.addGestureRecognizer(gestureRecognizer)
    }
    func setupImageSlider(){
        var updatedSliderAd = images
        sliderAlamoSource.removeAll()
        for i in 0..<images.count {
            if images[i] != "" {
           
            self.sliderAlamoSource.append(AlamofireSource(urlString: String(describing: images[i]))!)
                updatedSliderAd.append(images[i])
            }
        }
        images = updatedSliderAd
        imageSlider.setImageInputs(self.sliderAlamoSource)
      
    }
    @objc func didTap() {
        if images.count > 0 {
            let imageDisplayVC = ImageDisplayVC()
            imageDisplayVC.imgUrl = images[imageSlider.currentPage]
            imageDisplayVC.modalPresentationStyle = .custom
            imageDisplayVC.modalTransitionStyle = .crossDissolve
            present(imageDisplayVC, animated: true, completion: nil)
          
        }
    }
    
    func setupCollectionView() {
      
        sameUserAdsCollection.dataSource = self
        sameUserAdsCollection.delegate = self
        sameUserAdsCollection.register(UINib(nibName: ImageCellId, bundle: nil), forCellWithReuseIdentifier: ImageCellId)
        similarAdsCollection.dataSource = self
        similarAdsCollection.delegate = self
        similarAdsCollection.register(UINib(nibName: ImageCellId, bundle: nil), forCellWithReuseIdentifier: ImageCellId)
    }
    
    func setupView() {
        featuredAdLbl.isHidden = true
//        followUpBtn.isHidden = true
        
    

    }
    
    func loadData() {
        AdsService.instance.getAdById(id: selectedAdId) { (error, ad, images,imageUpdate, features, userAds, similarAds) in
            if let ad = ad {
                self.ad = ad
                ad.id = self.selectedAdId
                self.viewesLbl.text = "\(ad.AdViews)" + " " + "Views".localized
                if MOLHLanguage.currentAppleLanguage() == "ar" {
                    self.adTitleLbl.text = ad.titleAr
                    self.addTreeLbl.text = ad.CategoryNameAR + "-" + ad.SubCategoryNameAR + "-" + ad.SubSubCategoryNameAR
                    self.descLbl.text = ad.Description
                    self.adPriceLbl.text = "\(ad.price)" + " " + ad.cur

                } else {
                    self.adTitleLbl.text = ad.titleEn
                    self.addTreeLbl.text = ad.CategoryNameEN + "-" + ad.SubCategoryNameEN + "-" + ad.SubSubCategoryNameEN
                    self.descLbl.text = ad.DescriptionEN
                    self.adPriceLbl.text = "\(ad.price)" + " " + ad.curEn


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
//                self.dateLbl.text = ad.CreatedByEmail
                if ad.AdWithoutPhone == false {
                    self.adPhone = ad.PhoneNumber
                }
                self.shareLink = ad.ShareLink
                if ad.Featured == true {
                    self.featuredAdLbl.isHidden = false
                }
//                if ad.CreatedByEmail == NetworkHelper.getEmail() {
//                    self.followUpBtn.isHidden = false
//                }
            }
            if let images = images {
                self.stringImages = imageUpdate!
                print(self.stringImages.count)
                self.images = images
                
                self.setupImageSlider()
//                self.imagesCollection.reloadData()
            }
            if let features = features {
                self.features = features
            }
            if let userAds = userAds {
                self.userAds = userAds
                self.sameUserAdsCollection.reloadData()
                if userAds.count == 0 {
//                    self.adByUserViewHight.constant = 0
                    self.adByUserTitleHight.constant = 0
                    self.adByUserCollectionHight.constant = 0
                }
            }
            if let similarAds = similarAds {
                self.similarAds = similarAds
                self.similarAdsCollection.reloadData()
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
        }

    }
    
    @IBAction func whatsAppBtnPressed(_ sender: Any) {
        if adPhone == "" {
            let alert = UIAlertController(title: "", message: "There is no whatsapp for this ad".localized, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }
        else {
            var index = AppDelegate.countries.firstIndex(where: {$0.id == AppDelegate.cityId}) ?? 0
           
            let urlWhats = "https://wa.me/\("\(AppDelegate.countries[index].code ?? "965")" + adPhone)"
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
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func deleteAdAction(_ sender: Any) {
        
        if isRemoveAdHidden == 0{
            let alert = UIAlertController(title: "Delete!".localized, message: "Are you sure?".localized, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK".localized, style: UIAlertAction.Style.default) {
                UIAlertAction in
                AdsService.instance.removeAdd(completion: {
                    check in
                    
                    if check {
                        self.isRemoveAdHidden = 1
                        
                        self.removeAdBtn.setTitle("Republish".localized, for: .normal)
                    }
                    
                }, adID: self.selectedAdId)        }
            let cancelAction = UIAlertAction(title: "Cancel".localized, style: UIAlertAction.Style.cancel) {
                UIAlertAction in
            }
            
            // Add the actions
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let payActionSheet = PayActionSheet()
            payActionSheet.adId = self.selectedAdId
            payActionSheet.modalPresentationStyle = .custom
            present(payActionSheet, animated: true, completion: nil)
        }
        
    }
    @IBAction func updateAdAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UpdateAdvertiseNowVC") as! UpdateAdViewController
        vc.ad = self.ad
        vc.stringImages = self.stringImages
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func callBtnPressed(_ sender: Any) {
        if adPhone == "" {
            let alert = UIAlertController(title: "", message: "There is no number for this ad".localized, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 2
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
    
    @IBAction func shareBtnPressed(_ sender: Any) {
        print(shareLink)
        let text = "Check this ad: ".localized + "\(shareLink)\n" + "Download the app from this link: ".localized + "http://itunes.apple.com/app/id1511596620"
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
    
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = self.view //to set the source of your alert
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.maxY, width: 0, height: 0) // you can set this as per your requirement.
            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
        }
        
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)    }
    
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
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AdVC") as! AdVC
            vc.selectedAdId = userAds[indexPath.row].id
            navigationController?.pushViewController(vc, animated: true)
        }
        if collectionView.tag == 2 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AdVC") as! AdVC
            vc.selectedAdId = similarAds[indexPath.row].id
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
