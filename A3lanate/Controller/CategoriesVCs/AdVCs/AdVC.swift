//
//  AdVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/9/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

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
    
    
    //Constants
    let AdCellId = "AdCell"
    
    //Variables
    var selectedAdId: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
    }
    
    func setupView() {
        
    }
    
    func setupCollectionView() {
        imagesCollection.dataSource = self
        imagesCollection.delegate = self
        imagesCollection.register(UINib(nibName: AdCellId, bundle: nil), forCellWithReuseIdentifier: AdCellId)
        sameUserAdsCollection.dataSource = self
        sameUserAdsCollection.delegate = self
        sameUserAdsCollection.register(UINib(nibName: AdCellId, bundle: nil), forCellWithReuseIdentifier: AdCellId)
        similarAdsCollection.dataSource = self
        similarAdsCollection.delegate = self
        similarAdsCollection.register(UINib(nibName: AdCellId, bundle: nil), forCellWithReuseIdentifier: AdCellId)
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
}

extension AdVC: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return 4
        }
        if collectionView.tag == 1 {
            return 7
        }
        if collectionView.tag == 2 {
            return 7
        }
        else {
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdCellId, for: indexPath) as! AdCell
            return cell
        }
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdCellId, for: indexPath) as! AdCell
            return cell
        }
        if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdCellId, for: indexPath) as! AdCell
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdCellId, for: indexPath) as! AdCell
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

//        }
//        if collectionView.tag == 2 {
//            performSegue(withIdentifier: "toAdVC", sender: self)
//        }
//        if collectionView.tag == 3 {
//            performSegue(withIdentifier: "toAdVC", sender: self)
//        }
//        if collectionView.tag == 4 {
//            performSegue(withIdentifier: "toAdVC", sender: self)
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
