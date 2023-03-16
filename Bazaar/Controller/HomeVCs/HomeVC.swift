//
//  HomeVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//
//"Bazar".localized +
import UIKit
import ImageSlideshow
import SideMenuSwift
import MOLH
import Alamofire
import AlamofireImage
import NVActivityIndicatorView
import FSPagerView

class HomeVC: UIViewController {
    
    @IBOutlet weak var headerExtensionView: UIView!
    //Outlets
    @IBOutlet weak var sliderHieght: NSLayoutConstraint!
    @IBOutlet weak var countryBtn: UIButton!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var imageSlideshowContainer: UIView!
    @IBOutlet weak var imageSlideshow: ImageSlideshow!
    @IBOutlet weak var categoriesCollection: UICollectionView!
    @IBOutlet weak var featuredCollection: FSPagerView!
    @IBOutlet weak var recentCollection: FSPagerView!
    //    {
    //        didSet {
    //                   self.recentCollection.register(FSPagerViewCell.self, forCellWithReuseIdentifier: MainAdsCellID)
    //               }
    //    }
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var mostViewdCollection: FSPagerView!
    @IBOutlet weak var allBtn: UIButton!
  
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    @IBOutlet weak var mostViewedSlider: ImageSlideshow!
    @IBOutlet weak var recentSlider: ImageSlideshow!
    @IBOutlet weak var featuredSlider: ImageSlideshow!
    
    let button =  UIButton(type: .custom)
    
    
    @IBOutlet weak var commericalView: UIView!
    @IBOutlet weak var cCategoriesCollection: UICollectionView!
    @IBOutlet weak var commericalCollection: UICollectionView!
    @IBOutlet weak var cAdBtn: UIButton!
//    @IBOutlet weak var adBtn: UIButton!
    @IBOutlet weak var adsView: UIScrollView!
    
    @IBOutlet weak var commericalAdsBtn: UIButton!
    
    @IBOutlet weak var adsBtn: UIButton!
    
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
    var mostViewSliderArray = [Ad]()
    var reecentSliderArray = [Ad]()
    var featureSliderArray = [Ad]()
    var recentsliderAlamoSource = [AlamofireSource]()
    var mostViewedsliderAlamoSource = [AlamofireSource]()
    var seelectedFeature = Ad()
    var seelectedreeceent = Ad()
    var seelectedmostViewed = Ad()
    
    var CcategoriesArr = [Category]()
    var commericalAds = [Ad]()
    var page = 1
    var isTheLastPage = false
    var commericalCategoryId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAllSliders()
        setupCollectionView()
        //        changeLanguage()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.openAd(_:)), name: NSNotification.Name(rawValue: "openAd"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.openComAd(_:)), name: NSNotification.Name(rawValue: "openCom"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.openBalance(_:)), name: NSNotification.Name(rawValue: "opeenBalance"), object: nil)
        //
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setStatusBar(backgroundColor: UIColor(named: "main_color") ?? .white )
        
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        //        button.tintColor = #colorLiteral(red: 0.001686832751, green: 0.1439712048, blue: 0.4857619405, alpha: 1)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setImage(UIImage(named: "drop-down-1"), for: .normal)
        button.backgroundColor = .none
        button.addTarget(self, action: #selector(changeCountry), for: .touchUpInside)
        
        indicator.startAnimating()
        sliderAlamoSource.removeAll()
        recentsliderAlamoSource.removeAll()
        mostViewedsliderAlamoSource.removeAll()
        
        var index = AppDelegate.countries.firstIndex(where: {$0.id == AppDelegate.cityId}) ?? 0
        
        if AppDelegate.countries.count == 0{
            UtilitiesService.instance.getCounties(completion: {
                check, countries in
                if check == 0 {
                    AppDelegate.countries = countries
                    if AppDelegate.defaults.string(forKey: "cityId") != nil{
                        
                        AppDelegate.cityId = Int(AppDelegate.defaults.string(forKey: "cityId") ?? "0")!
                        
                    }else{
                        let index = AppDelegate.countries.firstIndex(where: {$0.nameEn == "Kuwait"}) ?? 0
                        AppDelegate.cityId = AppDelegate.countries[index].id
                        AppDelegate.defaults.setValue(AppDelegate.cityId, forKey: "cityId")
                        
                    }
                    self.button.setTitle( MOLHLanguage.currentAppleLanguage() == "ar" ? AppDelegate.countries[index].nameAr : AppDelegate.countries[index].nameEn, for: .normal)
                    
                }
            })
        }else{
            
            
            button.setTitle( MOLHLanguage.currentAppleLanguage() == "ar" ? AppDelegate.countries[index].nameAr : AppDelegate.countries[index].nameEn, for: .normal)
            
            navigationItem.titleView = button
            
        }
        loadData()
        getSliderBetweenAds()
        
    }
    @objc func openAd(_ notification: NSNotification){
        selectedAdId = notification.userInfo!["adId"] as! Int
        
        
        performSegue(withIdentifier: "toAdVC", sender: self)
        
        
        
    }
    @objc func openComAd(_ notification: NSNotification){
        selectedAdId = notification.userInfo!["adId"] as! Int
        self.performSegue(withIdentifier: "commerical_ads", sender: self)
        
        
    }
    @objc func openBalance(_ notification: NSNotification){
        self.performSegue(withIdentifier: "balance", sender: self)
        
    }
    
    @IBAction func commericalAdsAction(_ sender: Any) {
        cAdBtn.setTitleColor( #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        cAdBtn.backgroundColor =  #colorLiteral(red: 0.001686832751, green: 0.1439712048, blue: 0.4857619405, alpha: 1)
        adsBtn.setTitleColor(#colorLiteral(red: 0.001686832751, green: 0.1439712048, blue: 0.4857619405, alpha: 1),  for: .normal)
        adsBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        adsBtn.setTitleColor(#colorLiteral(red: 0.001686832751, green: 0.1439712048, blue: 0.4857619405, alpha: 1), for: .normal)
        adsView.isHidden = true
        commericalView.isHidden = false
    }
    
    @IBAction func storeBtnAction(_ sender: Any) {
        self.basicPresentation(storyName: "Store", segueId: "storeNa")
    }
    
    @IBAction func adsAction(_ sender: Any) {
        adsBtn.setTitleColor( #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        adsBtn.backgroundColor =  #colorLiteral(red: 0.001686832751, green: 0.1439712048, blue: 0.4857619405, alpha: 1)
        cAdBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cAdBtn.setTitleColor(#colorLiteral(red: 0.001686832751, green: 0.1439712048, blue: 0.4857619405, alpha: 1), for: .normal)
        
        adsView.isHidden = false
        commericalView.isHidden = true
    }
    
    @objc func changeCountry() {
        
        showCountryList()
    }
    func showCountryList(){
        let alertController = UIAlertController(title: "Choose country".localized, message: "", preferredStyle: .actionSheet)
        
        for item in AppDelegate.countries{
            let superbutton = UIAlertAction(title: MOLHLanguage.currentAppleLanguage() == "ar" ? item.nameAr : item.nameEn , style: .default, handler: { (action) in
                //                self.codeTF.text = item.code
                //                self.selectedCountry = item
                self.button.setTitle( MOLHLanguage.currentAppleLanguage() == "ar" ? item.nameAr : item.nameEn , for: .normal)
                AppDelegate.cityId = item.id
                
                AppDelegate.defaults.setValue(AppDelegate.cityId, forKey: "cityId")
                self.loadData()
                
            })
            
            alertController.addAction(superbutton)
        }
        let cancel = UIAlertAction(title: "Cancel".localized , style: .cancel, handler: { (action) in
            
            
        })
        alertController.addAction(cancel)
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view //to set the source of your alert
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
        }
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func showAllFeaturedAction(_ sender: Any) {
        self.performSegue(withIdentifier: "showmoretop", sender: self)
        
    }
    @IBAction func showAllMostViewdAction(_ sender: Any) {
        self.performSegue(withIdentifier: "showmoremost", sender: self)
        
    }
    @IBAction func showAllRecentAction(_ sender: Any) {
        self.performSegue(withIdentifier: "showmorelatest", sender: self)
        
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
            addActionSheetForiPad(actionSheet: alert)
            self.present(alert, animated: true, completion: {
            })
        }
    }
    func getComm(catId: Int){
        HomeService.instance.getComme(completion:{
            error, commericalAds in
            
            if error == nil{
                if commericalAds.count == 0{
                    self.isTheLastPage = true
                    self.page = self.page - 1
                }
                else if self.page == 1 && commericalAds.count != 0{
                    self.commericalAds = commericalAds
                }
                else{
                    self.commericalAds.append(contentsOf: commericalAds)
                }
            }
            else{
                self.commericalAds = commericalAds
                self.page = 1
            }
            
            self.commericalCollection.reloadData()
        } , catID: catId, page: page)
        
    }
    func setupView() {
        imageSlideshowContainer.addCornerRadius(cornerRadius: 30)
        self.headerExtensionView.addCornerRadius(cornerRadius: 25)
        self.headerExtensionView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
//        self.tabBarController?.tabBar.addCornerRadius(cornerRadius: 25)
//        self.tabBarController?.tabBar.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        self.cAdBtn.layer.borderWidth = 1
        self.cAdBtn.layer.borderColor = #colorLiteral(red: 0.001686832751, green: 0.1439712048, blue: 0.4857619405, alpha: 0.6992143037)
        self.adsBtn.layer.borderWidth = 1
        self.adsBtn.layer.borderColor = #colorLiteral(red: 0.001686832751, green: 0.1439712048, blue: 0.4857619405, alpha: 0.6989716789)
        //        self.cAdBtn.layer.addSpecificBorder(edge: .bottom, color: <#T##UIColor#>, thickness: <#T##CGFloat#>)()
    }
    
    func getSliderBetweenAds(){
        HomeService.instance.getbetweenSliderAds(type: 0,completion: { error, ads in
            self.featureSliderArray = ads
            self.featureslideShowSetup()
            
        })
        HomeService.instance.getbetweenSliderAds(type: 1,completion: { error, ads in
            self.reecentSliderArray = ads
            self.recentslideShowSetup()
            
        })
        HomeService.instance.getbetweenSliderAds(type: 2,completion: { error, ads in
            self.mostViewSliderArray = ads
            self.mostviewedslideShowSetup()
            
        })
    }
    
    func loadData() {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let width = Int(screenWidth) / 180
        self.getComm(catId: commericalCategoryId)
        
        HomeService.instance.getHome { (error, sliderAds, categories, topAds, mostViewedAds, latestAds) in
            if let sliderAds = sliderAds {
                self.sliderAds = sliderAds
                self.slideShowSetup()
            }
            if let categories = categories {
                self.categoriesArr = categories
                self.CcategoriesArr = categories
                let category = Category()
                category.id = 0
                category.nameAr = "الكل"
                category.nameEn = "All"
                
                self.CcategoriesArr.insert(category, at: 0)
                
                self.cCategoriesCollection.reloadData()
                
                
                self.categoriesCollection.reloadData()
            }
            if let topAds = topAds {
                print(topAds.count)
                self.topArr = topAds
                self.featuredCollection.reloadData()
                //                let screenSize = UIScreen.main.bounds
                //                let screenWidth = screenSize.width
                //                let width = Int(screenWidth) / 180
                //                let hight = (self.topArr.count / width) * 230
                //                self.featuredCollectionHight.constant = CGFloat(hight)
                //                if UIDevice.current.userInterfaceIdiom == .pad {
                //                    let hight = (self.topArr.count / width) * 230
                //                    self.featuredCollectionHight.constant = CGFloat(hight)
                //                } else {
                //                    let hight = (self.topArr.count / width) * 230
                //                    self.featuredCollectionHight.constant = CGFloat(hight)
                //                }
                
//                var hight = 0
//                if self.self.topArr.count == 1{
//                    hight = 230
//                    self.featuredCollectionHight.constant = CGFloat(hight)
//
//                }
//                else if self.self.topArr.count%2 !=  0{
//                    hight = ((self.topArr.count+1) / width) * 230
//                    self.featuredCollectionHight.constant = CGFloat(hight)
//
//                }
//
//                else{
//
//                    hight = (self.topArr.count / width) * 230
//                    self.featuredCollectionHight.constant = CGFloat(hight)
//
//                }
                
            }
            if let mostAds = mostViewedAds {
                self.mostViewdArr = mostAds
                //                self.mostViewdCollection.reloadData()
                self.topArr = mostAds

                self.recentCollection.reloadData()
                
                //                let screenSize = UIScreen.main.bounds
                //                let screenWidth = screenSize.width
                //                let width = Int(screenWidth) / 180
                //                var hight = 0
                //                if self.mostViewdArr.count == 1{
                //                     hight = 230
                //                    self.mostViewdCollectionHight.constant = CGFloat(hight)
                //
                //                } else if self.self.mostViewdArr.count%2 !=  0{
                //                    hight = ((self.mostViewdArr.count+1) / width) * 230
                //                    self.mostViewdCollectionHight.constant = CGFloat(hight)
                //
                //                }
                //
                //                else{
                //                    print(self.mostViewdArr.count)
                //                    print((self.mostViewdArr.count / width))
                //                     hight = (self.mostViewdArr.count / width) * 230
                //                    self.mostViewdCollectionHight.constant = CGFloat(hight)
                //
                //                }
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
                self.mostViewdCollection.reloadData()
                //                var hight = 0
                //                if self.latestArr.count == 1{
                //                     hight = 230
                //                    self.recentCollectionHight.constant = CGFloat(hight)
                //
                //                }else if self.self.latestArr.count%2 !=  0{
                //                    hight = ((self.latestArr.count+1) / width) * 230
                //                    self.recentCollectionHight.constant = CGFloat(hight)
                //
                //                }
                
                
                //                else{
                ////                    print(self.latestArr.count)
                ////                    print((self.latestArr.count / width))
                ////                     hight = (self.latestArr.count / width) * 230
                ////                    self.recentCollectionHight.constant = CGFloat(hight)
                //
                //
                //                }
                //                if UIDevice.current.userInterfaceIdiom == .pad {
                //                    let hight = (self.latestArr.count / 4) * 185
                //                    self.recentCollectionHight.constant = CGFloat(hight)
                //                } else {
                //                let hight = (self.latestArr.count / 2) * 185 + 70
                //                self.recentCollectionHight.constant = CGFloat(hight)
                //            }
            }
            self.slideShowSetup()
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
        }
    }
    
    func slideShowSetup() {
        var updatedSliderAd = sliderAds
        
        for i in 0..<sliderAds.count {
            if sliderAds[i].imgUrl != "" {
                
                self.sliderAlamoSource.append(AlamofireSource(urlString: String(describing: sliderAds[i].imgUrl))!)
                updatedSliderAd.append(sliderAds[i])
            }
        }
        sliderAds = updatedSliderAd
        imageSlideshow.setImageInputs(self.sliderAlamoSource)
        imageSlideshow.slideshowInterval = 3.0
        imageSlideshow.zoomEnabled = true
        imageSlideshow.contentScaleMode = .scaleToFill
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        imageSlideshow.addGestureRecognizer(gestureRecognizer)
        if sliderAds.count == 0{
            sliderHieght.constant = 0
            self.updateViewConstraints()
        }
    }
    func setupAllSliders(){
        featuredSlider.activityIndicator = DefaultActivityIndicator()
        
        featuredSlider.slideshowInterval = 3.0
        featuredSlider.contentScaleMode = .scaleToFill
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.featureDidTap))
        featuredSlider.addGestureRecognizer(gestureRecognizer)
        
        recentSlider.activityIndicator = DefaultActivityIndicator()
        
        recentSlider.slideshowInterval = 3.0
        recentSlider.contentScaleMode = .scaleToFill
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(self.recentDidTap))
        recentSlider.addGestureRecognizer(gestureRecognizer1)
        
        mostViewedSlider.activityIndicator = DefaultActivityIndicator()
        
        mostViewedSlider.slideshowInterval = 3.0
        mostViewedSlider.contentScaleMode = .scaleToFill
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(self.mostviewedDidTap))
        mostViewedSlider.addGestureRecognizer(gestureRecognizer2)
    }
    func featureslideShowSetup() {
        var updatedSliderAd = featureSliderArray
        var imags = [AnyObject]()
        
        for i in 0..<featureSliderArray.count {
            if featureSliderArray[i].imgUrl != "" {
                
                
                imags.append(AlamofireSource(urlString:featureSliderArray[i].imgUrl )!)
                
                updatedSliderAd.append(featureSliderArray[i])
            }
        }
        featureSliderArray = updatedSliderAd
        
        featuredSlider.setImageInputs(imags as! [InputSource])
        
    }
    func recentslideShowSetup() {
        var updatedSliderAd = reecentSliderArray
        
        for i in 0..<reecentSliderArray.count {
            if reecentSliderArray[i].imgUrl != "" {
                
                self.recentsliderAlamoSource.append(AlamofireSource(urlString: String(describing: reecentSliderArray[i].imgUrl))!)
                updatedSliderAd.append(reecentSliderArray[i])
            }
        }
        reecentSliderArray = updatedSliderAd
        recentSlider.setImageInputs(self.recentsliderAlamoSource)
        
    }
    func mostviewedslideShowSetup() {
        var updatedSliderAd = mostViewSliderArray
        
        for i in 0..<mostViewSliderArray.count {
            if mostViewSliderArray[i].imgUrl != "" {
                
                self.mostViewedsliderAlamoSource.append(AlamofireSource(urlString: String(describing: mostViewSliderArray[i].imgUrl))!)
                updatedSliderAd.append(mostViewSliderArray[i])
            }
        }
        mostViewSliderArray = updatedSliderAd
        mostViewedSlider.setImageInputs(self.mostViewedsliderAlamoSource)
        
    }
    
    
    @objc func didTap() {
        if sliderAds.count > 0 {
            self.selectedAdId = sliderAds[imageSlideshow.currentPage].adId
            self.performSegue(withIdentifier: "toAdVC", sender: self)
        }
    }
    @objc func featureDidTap() {
        if featureSliderArray.count > 0 {
            self.seelectedFeature = featureSliderArray[featuredSlider.currentPage]
            self.performSegue(withIdentifier: "slider_data", sender: self)
        }
    }
    @objc func recentDidTap() {
        if reecentSliderArray.count > 0 {
            self.seelectedFeature = reecentSliderArray[recentSlider.currentPage]
            self.performSegue(withIdentifier: "slider_data", sender: self)
        }
    }
    @objc func mostviewedDidTap() {
        if mostViewSliderArray.count > 0 {
            self.seelectedFeature = mostViewSliderArray[mostViewedSlider.currentPage]
            self.performSegue(withIdentifier: "slider_data", sender: self)
        }
    }
    
    func setupCollectionView() {
        categoriesCollection.delegate = self
        categoriesCollection.dataSource = self
        featuredCollection.delegate = self
        featuredCollection.dataSource = self
        recentCollection.delegate = self
        recentCollection.dataSource = self
        //        recentCollection.dataSource = self
        //        recentCollection.delegate = self
        mostViewdCollection.delegate = self
        mostViewdCollection.dataSource = self
        cCategoriesCollection.delegate = self
        cCategoriesCollection.dataSource = self
        categoriesCollection.register(UINib(nibName: MainCategoriesCellID, bundle: nil), forCellWithReuseIdentifier: MainCategoriesCellID)
        featuredCollection.register(UINib(nibName: MainAdsCellID, bundle: nil), forCellWithReuseIdentifier: MainAdsCellID)
        recentCollection.register(UINib(nibName: MainAdsCellID, bundle: Bundle.main), forCellWithReuseIdentifier: MainAdsCellID)
        mostViewdCollection.register(UINib(nibName: MainAdsCellID, bundle: Bundle.main), forCellWithReuseIdentifier: MainAdsCellID)
        cCategoriesCollection.register(UINib(nibName: MainCategoriesCellID, bundle: nil), forCellWithReuseIdentifier: MainCategoriesCellID)
        
        recentCollection.itemSize = CGSize(width: 0.75*recentCollection.frame.width, height: 178)
//        recentCollection.transformer = FSPagerViewTransformer(type: .)
        mostViewdCollection.itemSize = CGSize(width: 0.75*mostViewdCollection.frame.width, height: 178)
//        mostViewdCollection.transformer = FSPagerViewTransformer(type: .linear)
        featuredCollection.itemSize = CGSize(width: 0.75*featuredCollection.frame.width, height: 178)
        featuredCollection.transformer = FSPagerViewTransformer(type: .linear)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAdVC" {
            let destVC = segue.destination as! AdVC
            destVC.selectedAdId = self.selectedAdId
        }
        if segue.identifier == "toMainCatVC" {
            let destVC = segue.destination as! SubCategoryVC
            destVC.selectedMainCatId = self.selectedMainCatId
        }
        if segue.identifier == "commerical_ads"{
            let vc = segue.destination as! CommercialAdsViewController
            vc.commerceList = commericalAds
            let element = vc.commerceList.remove(at: selectedAdId)
            vc.commerceList.insert(element, at: 0)
            vc.selectedId = self.selectedAdId
        }
        if segue.identifier == "slider_data"{
            let vc = segue.destination as! SliderAdDetailsViewController
            vc.ad = seelectedFeature
        }
    }
    
    @IBAction func menuBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toMenuVC", sender: self)
    }
    
    @IBAction func searchBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toSearchVC", sender: self)
    }
    
    @IBAction func allBtnPressed(_ sender: Any) {
        //        performSegue(withIdentifier: "toAllOffersVC", sender: self)
        //        self.basicNavigation(storyName: "Main", segueId: "CategoriesVC")
        self.tabBarController?.selectedIndex = 1
        
    }
}
extension HomeVC: FSPagerViewDelegate, FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        if pagerView.tag == 2 {
            return topArr.count
        }
        else if pagerView.tag == 3 {
            print(mostViewdArr.count)
            return mostViewdArr.count
        }
        else if pagerView.tag == 4 {
            return latestArr.count
        }
        else
        {
            return 0
        }
    }
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        if pagerView.tag == 2 {
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: MainAdsCellID, at: index) as! MainAdsCell
            
            
            cell.setData(ad: topArr[index])
            return cell
        }
        else if pagerView.tag == 3 {
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: MainAdsCellID, at: index) as! MainAdsCell
            print("llllll")
            print(mostViewdArr[index].imgUrl)
            
            cell.setData(ad: mostViewdArr[index])
            
            return cell
        }
        else {
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: MainAdsCellID, at: index) as! MainAdsCell
            
            
            cell.setData(ad: latestArr[index])
            
            return cell
        }
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
        else if collectionView == cCategoriesCollection {
            return CcategoriesArr.count
        }
        
        //        if collectionView.tag == 3 {
        //            return mostViewdArr.count
        //        }
        //        if collectionView.tag == 4 {
        //            return latestArr.count
        //        }
        if collectionView.tag == 5 {
            print(commericalAds.count)
            return commericalAds.count
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
            print(categoriesArr[indexPath.row].imgUrl)
            
            cell.imgView.sd_setImage(with: URL(string: categoriesArr[indexPath.row].imgUrl), placeholderImage: UIImage(named: "placeholder.png"))
            
            return cell
        }  else if collectionView == cCategoriesCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCategoriesCellID, for: indexPath) as! MainCategoriesCell
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                cell.titleLbl.text = CcategoriesArr[indexPath.row].nameAr
                
            } else {
                cell.titleLbl.text = CcategoriesArr[indexPath.row].nameEn
            }
            if indexPath.row == 0{
                cell.imgView.image = #imageLiteral(resourceName: "learning")
            }else{
                cell.imgView.sd_setImage(with: URL(string: CcategoriesArr[indexPath.row].imgUrl), placeholderImage: UIImage(named: "placeholder.png"))
            }
            return cell
        }
        //        if collectionView.tag == 2 {
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAdsCellID, for: indexPath) as! MainAdsCell
        //
        //
        //            cell.setData(ad: topArr[indexPath.row])
        //            return cell
        //        }
        //        if collectionView.tag == 3 {
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAdsCellID, for: indexPath) as! MainAdsCell
        //            cell.setData(ad: mostViewdArr[indexPath.row])
        //
        //            return cell
        //        }
        //        if collectionView.tag == 4 {
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAdsCellID, for: indexPath) as! MainAdsCell
        //
        //
        //            cell.setData(ad: latestArr[indexPath.row])
        //
        //            return cell
        //        }
        if collectionView.tag == 5 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! commericalCollectionViewCell
            
            
            cell.setData(image: commericalAds[indexPath.row].imgUrl)
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAdsCellID, for: indexPath) as! MainAdsCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 || collectionView == cCategoriesCollection{
            return CGSize(width: 90, height: 100)
        }
        if collectionView.tag == 2 {
            var size: CGFloat = 220
            if StaticFunctions.getCurrentDevice() == "iPad"{
                size = (self.featuredCollection.bounds.width / 3) - 10
                return CGSize(width: size, height: 178)
                
                
            }else{
                size = (self.featuredCollection.bounds.width / 2) - 10
                return CGSize(width: size, height: 178)
                
            }
        }
        if collectionView.tag == 3 {
            var size: CGFloat = 220
            //            if StaticFunctions.getCurrentDevice() == "iPad"{
            size = self.featuredCollection.bounds.width - 130
            return CGSize(width: size, height: 178)
            
            
            //            }else{
            //             size = (self.featuredCollection.bounds.width / 2) - 10
            //                return CGSize(width: size, height: 178)
            
            //            }
        }
        if collectionView.tag == 4 {
            var size: CGFloat = 220
            //            if StaticFunctions.getCurrentDevice() == "iPad"{
            size = self.featuredCollection.bounds.width - 130
            return CGSize(width: size, height: 178)
            
            
            //            }else{
            //             size = (self.featuredCollection.bounds.width / 2) - 10
            //                return CGSize(width: size, height: 178)
            //
            //            }
        }
        if collectionView.tag == 5 {
            
            var cellWidth = (self.commericalCollection.bounds.width / 2) - 10
            var cellHight = (( UIScreen.main.bounds.size.height - 400) / 2)
            
            if cellWidth < 0 {
                cellWidth = 0
            }
            if cellHight < 0 {
                cellHight = 0
            }
            return CGSize(width: cellWidth, height: cellHight)
            
            
            
        }
        else {
            let size = (self.featuredCollection.bounds.width / 2) - 10
            return CGSize(width: size, height: 178)
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
        else if collectionView == cCategoriesCollection{
            self.commericalCategoryId = CcategoriesArr[indexPath.row].id
            self.page = 1
            self.isTheLastPage = false
            self.commericalAds.removeAll()
            getComm(catId: CcategoriesArr[indexPath.row].id)
            
        }
        if collectionView.tag == 2 {
            self.selectedAdId = topArr[indexPath.row].id
            performSegue(withIdentifier: "toAdVC", sender: self)
        }
        if collectionView.tag == 3 {
            self.selectedAdId = mostViewdArr[indexPath.row].id
            performSegue(withIdentifier: "toAdVC", sender: self)
        }
        if collectionView.tag == 4 {
            self.selectedAdId = latestArr[indexPath.row].id
            performSegue(withIdentifier: "toAdVC", sender: self)
        }
        
        if collectionView.tag == 5 {
            self.selectedAdId = indexPath.row
            self.performSegue(withIdentifier: "commerical_ads", sender: self)
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView.tag == 5 {
            let lastElement = commericalAds.count - 1
            if !isTheLastPage{
                if indexPath.row == lastElement {
                    self.page = page + 1
                    getComm(catId: commericalCategoryId)
                }
            }
        }
    }
}
extension CALayer {
    
    func addSpecificBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
            
        case UIRectEdge.bottom:
            border.frame = CGRect(x:0, y: frame.height - thickness, width: frame.width, height:thickness)
            
        case UIRectEdge.left:
            border.frame = CGRect(x:0, y:0, width: thickness, height: frame.height)
            
        case UIRectEdge.right:
            border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
            
        default: do {}
        }
        
        border.backgroundColor = color.cgColor
        
        addSublayer(border)
    }
}
