//
//  CommericalSliderCollectionViewCell.swift
//  ArabOnline
//
//  Created by Amal Elgalant on 2/27/20.
//  Copyright © 2020 developer team. All rights reserved.
//

import UIKit
import Alamofire
import MOLH
import SDWebImage

class CommericalSliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var whiteView: UIView!
//    @IBOutlet weak var topImageView: NSLayoutConstraint!
    @IBOutlet weak var buttonImageView: NSLayoutConstraint!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var viewsLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var adImageView: UIImageView!
    var currentVC = CommercialAdsViewController()
    var adID = 0
    
    func setData(commericalAd: Ad){
        likesLbl.text = String(commericalAd.AdLikes)
        viewsLbl.text = String(commericalAd.AdViews)
        if MOLHLanguage.currentAppleLanguage() == "en"{
            nameLbl.text = commericalAd.titleEn
        }else {
            nameLbl.text = commericalAd.titleAr
            
        }
        adID = commericalAd.id
        adImageView.sd_setImage(with: URL(string: commericalAd.imgUrl), placeholderImage: UIImage(named: "placeholder.png"))
     
        
        var swipeleft = UISwipeGestureRecognizer(target: self, action:  #selector(swipeup))
          swipeleft.direction = .up
        adImageView.addGestureRecognizer(swipeleft)
          var swiperight = UISwipeGestureRecognizer(target: self, action:  #selector(swipedown))
          swiperight.direction = .down
        adImageView.addGestureRecognizer(swiperight)
    }
    
    @IBAction func likeAdAction(_ sender: Any) {
        if NetworkHelper.getToken() == nil {
            let alert = UIAlertController(title: "", message: "You Should login first".localized, preferredStyle: .alert)
            currentVC.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
            
        }
        else{
            addAdtoFavorite(id: adID)
        }
        
    }
    func addAdtoFavorite(id : Int){
        //                if Reachability.isConnectedToNetwork(){
        //api/CommericalAds/PostCommircalAdLike/{CommAdId:int}
        if NetworkHelper.getToken() == nil {
            let alert = UIAlertController(title: "", message: "You Should login first".localized, preferredStyle: .alert)
            currentVC.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
            
        }
        else{
            let url = "\(COMMERICAL_ADS_LIKES)\(id)"
            print("login url \(url)")
            let headers = HEADER_BOTH
            //            let params : [String : Any] = ["CommAdId":id]
            Alamofire.request(url, method: .post, parameters: [:] , encoding: URLEncoding.httpBody, headers: headers ).responseJSON { (response) in
                print("response \(response.result.value )")
                
                if let likes = response.result.value as? Int{
                    self.likesLbl.text = String(likes)
                    
                    
                }
                
                
            }
            
            
        }
        //    }else{
        //    self.currentVC.showAlert(alertModel: AlertModel(alertTitle: "no internet" , alertMessage: "check your internet connection", alertType: .Cancel))
        //    }
    }
    @objc func swipeup(sender: UITapGestureRecognizer? = nil) {
           // Do what u want here
     
        whiteView.isHidden = false
//        topImageView.constant = 0
        buttonImageView.constant = 70
       }

    @objc func swipedown(sender: UITapGestureRecognizer? = nil) {
           // Do what u want here
        whiteView.isHidden = true
//        topImageView.constant = 70
        buttonImageView.constant = 0
       }
}
