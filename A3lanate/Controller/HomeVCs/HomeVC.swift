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
    
    //Constants
    let MainAdsCellID = "MainAdsCell"
    let MainCategoriesCellID = "MainCategoriesCell"
    
    //Variables
    var sliderAds = [SliderAd]()
    var categoriesArr = [Category]()
    var topArr = [Ad]()
    var mostViewdArr = [Ad]()
    var latestArr = [Ad]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideShowSetup()
        setupView()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
    }
    
    func setupView() {
        imageSlideshowContainer.addCornerRadius(cornerRadius: 30)
        self.navigationController?.navigationBar.addCornerRadius(cornerRadius: 25)
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        self.tabBarController?.tabBar.addCornerRadius(cornerRadius: 25)
        self.tabBarController?.tabBar.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
    }
    
    func loadData() {
        HomeService.instance.getHome { (error, sliderAds, categories, topAds, mostViewedAds, latestAds) in
            if let sliderAds = sliderAds {
                self.sliderAds = sliderAds
            }
            if let categories = categories {
                self.categoriesArr = categories
                self.categoriesCollection.reloadData()
            }
            if let topAds = topAds {
                self.topArr = topAds
                self.featuredCollection.reloadData()
            }
            if let mostAds = mostViewedAds {
                self.mostViewdArr = mostAds
                self.mostViewdCollection.reloadData()
            }
            if let latestAds = latestAds {
                self.latestArr = latestAds
                self.recentCollection.reloadData()
            }
        }
    }
    
    func slideShowSetup() {
    imageSlideshow.setImageInputs([ImageSource(image: UIImage(named: "0")!), ImageSource(image: UIImage(named: "1")!)])
        imageSlideshow.slideshowInterval = 3.0
        imageSlideshow.zoomEnabled = true
        imageSlideshow.contentScaleMode = .scaleToFill
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCategoriesCellID, for: indexPath)
            return cell
        }
        if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAdsCellID, for: indexPath)
            return cell
        }
        if collectionView.tag == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAdsCellID, for: indexPath)
            return cell
        }
        if collectionView.tag == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAdsCellID, for: indexPath)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAdsCellID, for: indexPath)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: 80, height: 80)
        }
        if collectionView.tag == 2 {
            return CGSize(width: 160, height: 170)
        }
        if collectionView.tag == 3 {
            return CGSize(width: 160, height: 170)
        }
        if collectionView.tag == 4 {
            return CGSize(width: 160, height: 170)
        }
        else {
            return CGSize(width: 160, height: 170)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView.tag == 1 {
//            let cell = collectionView.cellForItem(at: indexPath) as! MainCategoriesCell
//            cell.titleLbl.isHidden = false
//        }
        if collectionView.tag == 2 {
            performSegue(withIdentifier: "toAdVC", sender: self)
        }
        if collectionView.tag == 3 {
            performSegue(withIdentifier: "toAdVC", sender: self)
        }
        if collectionView.tag == 4 {
            performSegue(withIdentifier: "toAdVC", sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        if collectionView.tag == 1 {
//            let cell = collectionView.cellForItem(at: indexPath) as! MainCategoriesCell
//            cell.titleLbl.isHidden = true
//        }
//      if collectionView.tag == 2 {
//      }
//      if collectionView.tag == 3 {
//      }
//      if collectionView.tag == 4 {
//      }
    }
}
