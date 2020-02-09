//
//  SubCategoryVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/7/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class SubCategoryVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var subCategoryNameLbl: UILabel!
    @IBOutlet weak var subSubCategoryCollection: UICollectionView!
    @IBOutlet weak var subCategoryCollection: UICollectionView!
    
    //Constants
    let SubSubCategoryCellId = "SubSubCategoryCell"
    let SubCategoryCellId = "SubCategoryCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
    }
    
    func setupView() {
        subSubCategoryCollection.addCornerRadius(cornerRadius: 30)
    }
    
    func setupCollectionView() {
        subCategoryCollection.delegate = self
        subSubCategoryCollection.delegate = self
        subCategoryCollection.dataSource = self
        subSubCategoryCollection.dataSource = self
        subSubCategoryCollection.register(UINib(nibName: SubSubCategoryCellId, bundle: nil), forCellWithReuseIdentifier: SubSubCategoryCellId)
        subCategoryCollection.register(UINib(nibName: SubCategoryCellId, bundle: nil), forCellWithReuseIdentifier: SubCategoryCellId)
    }
}


extension SubCategoryVC: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return 10
        }
        if collectionView.tag == 2 {
            return 12
        }
        else {
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubSubCategoryCellId, for: indexPath)
            return cell
        }
        if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubCategoryCellId, for: indexPath)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubCategoryCellId, for: indexPath)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: 170, height: 60)
        }
        if collectionView.tag == 2 {
            return CGSize(width: 170, height: 180)
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
//        if collectionView.tag == 2 {
//        }
//        if collectionView.tag == 3 {
//        }
//        if collectionView.tag == 4 {
//        }
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
