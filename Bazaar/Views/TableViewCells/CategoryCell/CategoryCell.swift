//
//  CategoryCell.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH
import Alamofire
import AlamofireImage

class CategoryCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var catNameLbl: UILabel!
    @IBOutlet weak var subCategoryCollectionView: UICollectionView!
    @IBOutlet weak var adsCollectionView: UICollectionView!
    
    //Constants
    let MainCategoriesCellId = "MainCategoriesCell"
    let AdCellId = "AdCell"
    
    //Variables
    var parent: CategoriesVC?
    var ads = [Ad]()
    var subCategories = [SubCategory]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupCollectionView()
    }
    
    override func prepareForReuse() {
        self.ads = [Ad]()
        self.subCategories = [SubCategory]()
        self.subCategoryCollectionView.reloadData()
        self.adsCollectionView.reloadData()
    }
    
    func setupView() {
        mainView.addBorder()
        mainView.addCornerRadius(cornerRadius: 30)
    }
    
    func setupCollectionView() {
        subCategoryCollectionView.delegate = self
        subCategoryCollectionView.dataSource = self
        subCategoryCollectionView.register(UINib(nibName: MainCategoriesCellId, bundle: nil), forCellWithReuseIdentifier: MainCategoriesCellId)
        adsCollectionView.delegate = self
        adsCollectionView.dataSource = self
        adsCollectionView.register(UINib(nibName: AdCellId, bundle: nil), forCellWithReuseIdentifier: AdCellId)
    }
    
    
}

extension CategoryCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            if subCategories.count == 0 {
                return 1
            } else {
                return subCategories.count
            }
        }
        if collectionView.tag == 2 {
            if ads.count == 0 {
                return 1
            } else {
                return ads.count
            }
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            if subCategories.count == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCategoriesCellId, for: indexPath) as! MainCategoriesCell
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCategoriesCellId, for: indexPath) as! MainCategoriesCell
                if MOLHLanguage.currentAppleLanguage() == "ar" {
                    cell.titleLbl.text = subCategories[indexPath.row].nameAr
                } else {
                    cell.titleLbl.text = subCategories[indexPath.row].nameEn
                }
                Alamofire.request(subCategories[indexPath.row].imgUrl).responseImage { (response) in
                    if let image = response.result.value {
                        DispatchQueue.main.async {
                            cell.imgView.image = image
                        }
                    }
                }
                return cell
            }
        }
        if collectionView.tag == 2 {
            if ads.count == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdCellId, for: indexPath) as! AdCell
                return cell
                
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdCellId, for: indexPath) as! AdCell
                let imgUrl = ads[indexPath.row].imgArr[0]
                Alamofire.request(imgUrl).responseImage { (response) in
                    if let image = response.result.value {
                        DispatchQueue.main.async {
                            cell.cellImg.image = image
                        }
                    }
                }
                
                return cell
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCategoriesCellId, for: indexPath) as! MainCategoriesCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: 90, height: 90)
        }
        if collectionView.tag == 2 {
            return CGSize(width: 170, height: 120)
            
        } else {
            return CGSize(width: 90, height: 80)
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
                            self.parent?.selectedCatId = self.subCategories[indexPath.row].id
                            self.parent?.performSegue(withIdentifier: "toSubCategoryVC", sender: self)
            })
        }
        if collectionView.tag == 2 {
            parent?.selectedAdId = ads[indexPath.row].id
            parent?.performSegue(withIdentifier: "toAdVC", sender: self)
        }
    }
    
}
