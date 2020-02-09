//
//  CategoriesVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 1/23/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import ImageSlideshow

class CategoriesVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var slideshowView: UIView!
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Constants
    let CategoriesCellId = "CategoriesCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        slideShowSetup()
        setupCollectionView()
    }
    
    func setupView() {
        self.navigationController?.navigationBar.addCornerRadius(cornerRadius: 25)
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        self.tabBarController?.tabBar.addCornerRadius(cornerRadius: 25)
        self.tabBarController?.tabBar.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        slideshowView.addCornerRadius(cornerRadius: 25)
        collectionView.addCornerRadius(cornerRadius: 40)
    }
    
    func slideShowSetup() {
        slideShow.setImageInputs([ImageSource(image: UIImage(named: "0")!), ImageSource(image: UIImage(named: "1")!)])
        slideShow.slideshowInterval = 3.0
        slideShow.zoomEnabled = true
        slideShow.contentScaleMode = .scaleAspectFill
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: CategoriesCellId, bundle: nil), forCellWithReuseIdentifier: CategoriesCellId)
    }
}

extension CategoriesVC: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCellId, for: indexPath) as! CategoriesCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 180)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toCategoryVC", sender: self)
    }
}
