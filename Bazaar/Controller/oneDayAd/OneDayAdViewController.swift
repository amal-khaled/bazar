//
//  OneDayAdViewController.swift
//  Bazaar
//
//  Created by Amal Elgalant on 01/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import ImageSlideshow

class OneDayAdViewController: UIViewController {
    
    @IBOutlet weak var balanceBtn: UIButton!
    @IBOutlet weak var linkView: UIView!
    @IBOutlet weak var imageSlideShow: ImageSlideshow!
    var ads = [Ad]()
    var sliderAlamoSource = [AlamofireSource]()
    var selected = false
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderAlamoSource.removeAll()
        getAds()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        linkView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    
    func slideShowSetup() {
        for i in 0..<ads.count {
            self.sliderAlamoSource.append(AlamofireSource(urlString: String(describing: ads[i].imgUrl))!)
        }
        imageSlideShow.setImageInputs(self.sliderAlamoSource)
        imageSlideShow.slideshowInterval = 10
        imageSlideShow.zoomEnabled = true
        imageSlideShow.contentScaleMode = .scaleToFill
        imageSlideShow.cornerRadius = 20
        imageSlideShow.clipsToBounds = true
        imageSlideShow.delegate = self
        if ads.count > 0 {
        if self.ads[0].hasLink{
            self.balanceBtn.isHidden = true
        }else{
            self.balanceBtn.isHidden = false

        }
        }
        imageSlideShow.shadowOffset = CGSize(width: 1, height:1)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        imageSlideShow.addGestureRecognizer(gestureRecognizer)
        imageSlideShow.currentPageChanged = { page in
            if self.ads[page].hasLink{
                self.balanceBtn.isHidden = true
            }else{
                self.balanceBtn.isHidden = false

            }
            
        }
    }
    @IBAction func skipAction(_ sender: Any) {
        self.basicPresentation(storyName: "Main", segueId: "mainTabBar")
    }
    @IBAction func openLinkAction(_ sender: Any) {
        if ads.count > 0 {
            guard let url = URL(string: ads[imageSlideShow.currentPage].link) else { return }
            UIApplication.shared.open(url)
            self.selected = false
            self.linkView.isHidden = true
        }
        
    }
    @IBAction func balanceBtnAction(_ sender: Any) {
        if NetworkHelper.getToken() == nil {
            performSegue(withIdentifier: "toLoginVC", sender: self)
        }else{
            let buyPackageVC = BuyPackageVC()
            buyPackageVC.modalPresentationStyle = .custom
            buyPackageVC.modalTransitionStyle = .crossDissolve
            present(buyPackageVC, animated: true, completion: nil)
        }
    }
    @objc func didTap() {
        if ads[imageSlideShow.currentPage].hasLink{
        linkView.isHidden = selected
        selected = !selected
        }else{
            if NetworkHelper.getToken() == nil {
                performSegue(withIdentifier: "toLoginVC", sender: self)
            }else{
                let buyPackageVC = BuyPackageVC()
                buyPackageVC.modalPresentationStyle = .custom
                buyPackageVC.modalTransitionStyle = .crossDissolve
                present(buyPackageVC, animated: true, completion: nil)
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension OneDayAdViewController{
    func getAds(){
        HomeService.instance.getOneDayAd(completion: { error, ads in
            self.ads = ads
            self.slideShowSetup()
            
        })
    }
}
extension OneDayAdViewController: ImageSlideshowDelegate{
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        self.selected = false
        self.linkView.isHidden = true
    }
}
