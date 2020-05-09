//
//  HomeVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 1/23/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import ImageSlideshow
import SideMenuSwift
import MOLH
import Alamofire
import AlamofireImage
import NVActivityIndicatorView

class HomeVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var imageSlideshowContainer: UIView!
    @IBOutlet weak var imageSlideshow: ImageSlideshow!
    @IBOutlet weak var categoriesCollection: UICollectionView!
    @IBOutlet weak var featuredCollection: UICollectionView!
    @IBOutlet weak var recentCollection: UICollectionView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var mostViewdCollection: UICollectionView!
    @IBOutlet weak var allBtn: UIButton!
    @IBOutlet weak var featuredCollectionHight: NSLayoutConstraint!
    @IBOutlet weak var recentCollectionHight: NSLayoutConstraint!
    @IBOutlet weak var mostViewdCollectionHight: NSLayoutConstraint!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    
    //Constants
    let MainAdsCellID = "MainAdsCell"
    let MainCategoriesCellID = "MainCategoriesCell"
    
    //Variables
    var sliderAds = [SliderAd]()
    var categoriesArr = [Category]()
    var topArr = [Ad]()
    var mostViewdArr = [Ad]()
    var latestArr = [Ad]()
    var sliderAlamoSource = [AlamofireSource]()
    var selectedAdId: Int = 0
    var selectedMainCatId: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
//        changeLanguage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        indicator.startAnimating()
        loadData()
    }
    
    func changeLanguage() {
        if MOLHLanguage.isArabic() {
            return
        } else {
            let alert = UIAlertController(title: "Default Language", message: "Do you want to change the app language to Arabic?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default , handler:{ (UIAlertAction)in
                MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "ar")
                        if #available(iOS 13.0, *) {
                        let delegate = UIApplication.shared.delegate as? AppDelegate
                        delegate!.swichRoot()
                } else {
                       // Fallback on earlier versions
                       MOLH.reset()
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
                self.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true, completion: {
            })
        }
    }
    
    func setupView() {
        imageSlideshowContainer.addCornerRadius(cornerRadius: 30)
        self.navigationController?.navigationBar.addCornerRadius(cornerRadius: 25)
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        self.tabBarController?.tabBar.addCornerRadius(cornerRadius: 25)
        self.tabBarController?.tabBar.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
    }
    
    func loadData() {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let width = Int(screenWidth) / 180
        HomeService.instance.getHome { (error, sliderAds, categories, topAds, mostViewedAds, latestAds) in
            if let sliderAds = sliderAds {
                self.sliderAds = sliderAds
                self.slideShowSetup()
            }
            if let categories = categories {
                self.categoriesArr = categories
                self.categoriesCollection.reloadData()
            }
            if let topAds = topAds {
                self.topArr = topAds
                self.featuredCollection.reloadData()
//                let screenSize = UIScreen.main.bounds
//                let screenWidth = screenSize.width
//                let width = Int(screenWidth) / 180
                let hight = (self.topArr.count / width) * 230
                self.featuredCollectionHight.constant = CGFloat(hight)
//                if UIDevice.current.userInterfaceIdiom == .pad {
//                    let hight = (self.topArr.count / width) * 230
//                    self.featuredCollectionHight.constant = CGFloat(hight)
//                } else {
//                    let hight = (self.topArr.count / width) * 230
//                    self.featuredCollectionHight.constant = CGFloat(hight)
//                }
            }
            if let mostAds = mostViewedAds {
                self.mostViewdArr = mostAds
                self.mostViewdCollection.reloadData()
//                let screenSize = UIScreen.main.bounds
//                let screenWidth = screenSize.width
//                let width = Int(screenWidth) / 180
                let hight = (self.mostViewdArr.count / width) * 230
                self.mostViewdCollectionHight.constant = CGFloat(hight)
//                if UIDevice.current.userInterfaceIdiom == .pad {
//                    let hight = (self.mostViewdArr.count / 4) * 185
//                    self.mostViewdCollectionHight.constant = CGFloat(hight)
//                } else {
//                let hight = (self.mostViewdArr.count / 2) * 185 + 70
//                self.mostViewdCollectionHight.constant = CGFloat(hight)
//                }
            }
            if let latestAds = latestAds {
                self.latestArr = latestAds
                self.recentCollection.reloadData()
                let hight = (self.latestArr.count / width) * 230
                self.recentCollectionHight.constant = CGFloat(hight)
//                if UIDevice.current.userInterfaceIdiom == .pad {
//                    let hight = (self.latestArr.count / 4) * 185
//                    self.recentCollectionHight.constant = CGFloat(hight)
//                } else {
//                let hight = (self.latestArr.count / 2) * 185 + 70
//                self.recentCollectionHight.constant = CGFloat(hight)
//            }
            }
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
        }
    }
    
    func slideShowSetup() {
        for i in 0..<sliderAds.count {
            self.sliderAlamoSource.append(AlamofireSource(urlString: String(describing: sliderAds[i].imgUrl))!)
        }
        imageSlideshow.setImageInputs(self.sliderAlamoSource)
        imageSlideshow.slideshowInterval = 3.0
        imageSlideshow.zoomEnabled = true
        imageSlideshow.contentScaleMode = .scaleToFill
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        imageSlideshow.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func didTap() {
        if sliderAds.count > 0 {
            self.selectedAdId = sliderAds[imageSlideshow.currentPage].adId
            self.performSegue(withIdentifier: "toAdVC", sender: self)
        }
    }
    
    func setupCollectionView() {
        categoriesCollection.delegate = self
        categoriesCollection.dataSource = self
        featuredCollection.delegate = self
        featuredCollection.dataSource = self
        recentCollection.delegate = self
        recentCollection.dataSource = self
        mostViewdCollection.delegate = self
        mostViewdCollection.dataSource = self
        categoriesCollection.register(UINib(nibName: MainCategoriesCellID, bundle: nil), forCellWithReuseIdentifier: MainCategoriesCellID)
        featuredCollection.register(UINib(nibName: MainAdsCellID, bundle: nil), forCellWithReuseIdentifier: MainAdsCellID)
        recentCollection.register(UINib(nibName: MainAdsCellID, bundle: nil), forCellWithReuseIdentifier: MainAdsCellID)
        mostViewdCollection.register(UINib(nibName: MainAdsCellID, bundle: nil), forCellWithReuseIdentifier: MainAdsCellID)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAdVC" {
            let destVC = segue.destination as! AdVC
            destVC.selectedAdId = self.selectedAdId
        }
        if segue.identifier == "toMainCatVC" {
            let destVC = segue.destination as! MainCatVC
            destVC.selectedMainCatId = self.selectedMainCatId
        }
    }
    
    @IBAction func menuBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toMenuVC", sender: self)
    }
    
    @IBAction func searchBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toSearchVC", sender: self)
    }
    
    @IBAction func allBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toAllOffersVC", sender: self)
    }
}

extension HomeVC: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return categoriesArr.count
        }
        if collectionView.tag == 2 {
            return topArr.count
        }
        if collectionView.tag == 3 {
            return mostViewdArr.count
        }
        if collectionView.tag == 4 {
            return latestArr.count
        }
        else {
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCategoriesCellID, for: indexPath) as! MainCategoriesCell
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                cell.titleLbl.text = categoriesArr[indexPath.row].nameAr
            } else {
                cell.titleLbl.text = categoriesArr[indexPath.row].nameEn
            }
            Alamofire.request(categoriesArr[indexPath.row].imgUrl).responseImage { (response) in
                if let image = response.result.value {
                    DispatchQueue.main.async {
                        cell.imgView.image = image
                    }
                }
            }
            return cell
        }
        if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAdsCellID, for: indexPath) as! MainAdsCell
            
            Alamofire.request(topArr[indexPath.row].imgUrl).responseImage { (response) in
                if let image = response.result.value {
                    DispatchQueue.main.async {
                        cell.imgView.image = image
                    }
                }
            }
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                cell.typeLbl.text = topArr[indexPath.row].titleAr
            } else {
                cell.typeLbl.text = topArr[indexPath.row].titleEn
            }
            cell.priceLbl.text = "Featured Ad".localized
            cell.priceLbl.textColor = #colorLiteral(red: 0.932130754, green: 0.6688258052, blue: 0, alpha: 1)
            cell.currencyLbl.text = ""
            if topArr[indexPath.row].isLoved == true {
                cell.likeImg.image = UIImage(named: "likeR")
            }
            cell.btnPressed = { [weak self] in
                if NetworkHelper.getToken() != nil {
                AdsService.instance.favoriteAdById(Id: (self?.topArr[indexPath.row].id)!) { (success) in
                    if success {
                        if cell.likeImg.image == UIImage(named: "likeR") {
                            cell.likeImg.image = UIImage(named: "likeG")
                        } else {
                        cell.likeImg.image = UIImage(named: "likeR")
                        }
                    }
                }
                } else {
                    let alert = UIAlertController(title: "", message: "You Should login first".localized, preferredStyle: .alert)
                    self?.present(alert, animated: true, completion: nil)
                    let when = DispatchTime.now() + 3
                    DispatchQueue.main.asyncAfter(deadline: when){
                        alert.dismiss(animated: true, completion: nil)
                    }
                }
            }
            return cell
        }
        if collectionView.tag == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAdsCellID, for: indexPath) as! MainAdsCell
            Alamofire.request(latestArr[indexPath.row].imgUrl).responseImage { (response) in
                if let image = response.result.value {
                    DispatchQueue.main.async {
                        cell.imgView.image = image
                    }
                }
            }
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                cell.typeLbl.text = latestArr[indexPath.row].titleAr
            } else {
                cell.typeLbl.text = latestArr[indexPath.row].titleEn
            }
            cell.priceLbl.text = "\(latestArr[indexPath.row].price)" + "KWD".localized
            cell.priceLbl.textColor = #colorLiteral(red: 0.932130754, green: 0.6688258052, blue: 0, alpha: 1)
            cell.currencyLbl.text = ""
            if latestArr[indexPath.row].isLoved == true {
                cell.likeImg.image = UIImage(named: "likeR")
            }
            cell.btnPressed = { [weak self] in
                if NetworkHelper.getToken() != nil {
                AdsService.instance.favoriteAdById(Id: (self?.topArr[indexPath.row].id)!) { (success) in
                    if success {
                        if cell.likeImg.image == UIImage(named: "likeR") {
                            cell.likeImg.image = UIImage(named: "likeG")
                        } else {
                        cell.likeImg.image = UIImage(named: "likeR")
                        }                    }
                }
                } else {
                    let alert = UIAlertController(title: "", message: "You Should login first".localized, preferredStyle: .alert)
                    self?.present(alert, animated: true, completion: nil)
                    let when = DispatchTime.now() + 3
                    DispatchQueue.main.asyncAfter(deadline: when){
                        alert.dismiss(animated: true, completion: nil)
                    }
                }
            }
            return cell
        }
        if collectionView.tag == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAdsCellID, for: indexPath) as! MainAdsCell
            Alamofire.request(mostViewdArr[indexPath.row].imgUrl).responseImage { (response) in
                if let image = response.result.value {
                    DispatchQueue.main.async {
                        cell.imgView.image = image
                    }
                }
            }
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                cell.typeLbl.text = mostViewdArr[indexPath.row].titleAr
            } else {
                cell.typeLbl.text = mostViewdArr[indexPath.row].titleEn
            }
            cell.priceLbl.text = "\(mostViewdArr[indexPath.row].price)" + "KWD".localized
            cell.priceLbl.textColor = #colorLiteral(red: 0.932130754, green: 0.6688258052, blue: 0, alpha: 1)
            cell.currencyLbl.text = ""

            if mostViewdArr[indexPath.row].isLoved == true {
                cell.likeImg.image = UIImage(named: "likeR")
            }
            cell.btnPressed = { [weak self] in
                if NetworkHelper.getToken() != nil {
                AdsService.instance.favoriteAdById(Id: (self?.topArr[indexPath.row].id)!) { (success) in
                    if success {
                        if cell.likeImg.image == UIImage(named: "likeR") {
                            cell.likeImg.image = UIImage(named: "likeG")
                        } else {
                        cell.likeImg.image = UIImage(named: "likeR")
                        }
                    }
                }
                    } else {
                        let alert = UIAlertController(title: "", message: "You Should login first".localized, preferredStyle: .alert)
                        self?.present(alert, animated: true, completion: nil)
                        let when = DispatchTime.now() + 3
                        DispatchQueue.main.asyncAfter(deadline: when){
                            alert.dismiss(animated: true, completion: nil)
                        }
                    }
            }
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAdsCellID, for: indexPath) as! MainAdsCell
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: 90, height: 90)
        }
        if collectionView.tag == 2 {
            return CGSize(width: 180, height: 220)
        }
        if collectionView.tag == 3 {
            return CGSize(width: 180, height: 220)
        }
        if collectionView.tag == 4 {
            return CGSize(width: 180, height: 220)
        }
        else {
            return CGSize(width: 180, height: 220)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            let cell = collectionView.cellForItem(at: indexPath)
            UIView.animate(withDuration: 0.2,
                           animations: {
                            cell?.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            },
                           completion: { _ in
                            UIView.animate(withDuration: 0.2) {
                                cell?.transform = CGAffineTransform.identity
                            }
                            self.selectedMainCatId = self.categoriesArr[indexPath.row].id
                            self.performSegue(withIdentifier: "toMainCatVC", sender: self)
            })

        }
        if collectionView.tag == 2 {
            self.selectedAdId = topArr[indexPath.row].id
            performSegue(withIdentifier: "toAdVC", sender: self)
        }
        if collectionView.tag == 3 {
            self.selectedAdId = latestArr[indexPath.row].id
            performSegue(withIdentifier: "toAdVC", sender: self)
        }
        if collectionView.tag == 4 {
            self.selectedAdId = mostViewdArr[indexPath.row].id
            performSegue(withIdentifier: "toAdVC", sender: self)
        }
    }
}
