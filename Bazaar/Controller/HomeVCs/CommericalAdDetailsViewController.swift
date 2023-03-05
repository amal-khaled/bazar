//
//  CommericalAdDetailsViewController.swift
//  ArabOnline
//
//  Created by Amal Elgalant on 2/28/20.
//  Copyright © 2020 developer team. All rights reserved.
//

import UIKit
import Alamofire
//import MSPeekCollectionViewDelegateImplementation

class CommericalAdDetailsViewController: UIViewController {
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    @IBOutlet weak var numberOfLikes: UILabel!
    @IBOutlet weak var numberOfViews: UILabel!
    @IBOutlet weak var totalItems: UILabel!
    @IBOutlet weak var currentIndex: UILabel!
//    var behavior: MSCollectionViewPeekingBehavior!
    var currentImageslider = 0
    var commericalAd = Ad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        behavior = MSCollectionViewPeekingBehavior()
//        behavior = MSCollectionViewPeekingBehavior(minimumItemsToScroll: 1)
        
        
//        sliderCollectionView.configureForPeekingBehavior(behavior: behavior)
//        behavior = MSCollectionViewPeekingBehavior(numberOfItemsToShow: 1)
//        sliderCollectionView.configureForPeekingBehavior(behavior: behavior)
//
//        behavior.scrollToItem(at: 1, animated: true)
        numberOfLikes.text = String(commericalAd.AdLikes)
        numberOfViews.text = String(commericalAd.AdViews)
        totalItems.text = String(commericalAd.imgArr.count)
        
    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        getAdDetails()
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.hidesBottomBarWhenPushed = false
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func closeAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func linkAction(_ sender: Any) {
        guard let url = URL(string: commericalAd.link) else { return }
        UIApplication.shared.open(url)
    }
    @IBAction func likeAdAction(_ sender: Any) {
        if NetworkHelper.getToken() == nil {
            let alert = UIAlertController(title: "", message: "You Should login first".localized, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
            
        }
        else{
            addAdtoFavorite(id: commericalAd.id)
        }
    }
    func addAdtoFavorite(id : Int){
        //                if Reachability.isConnectedToNetwork(){
        //api/CommericalAds/PostCommircalAdLike/{CommAdId:int}
        let url = "\(COMMERICAL_ADS_LIKES)\(id)"
        print("login url \(url)")
        let headers = HEADER_BOTH
        //            let params : [String : Any] = ["CommAdId":id]
        Alamofire.request(url, method: .post, parameters: [:] , encoding: URLEncoding.httpBody, headers: headers ).responseJSON { (response) in
            print("response \(response.result.value )")
            
            if let likes = response.result.value as? Int{
                self.numberOfLikes.text = String(likes)
                
                
                
                
                
            }
            
            
        }
        
    }
    
    @IBAction func shareAction(_ sender: Any) {
        
        let text = "Check this ad: ".localized + "\(commericalAd.imgArr[currentImageslider])\n" + "Download the app from this link: ".localized + "http://itunes.apple.com/app/id1511596620"
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
    
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = self.view //to set the source of your alert
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.maxY, width: 0, height: 0) // you can set this as per your requirement.
            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
        }
        
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func phoneAction(_ sender: Any) {
        
        call(phone: self.commericalAd.PhoneNumber)
        
    }
    func call(phone : String){
        if phone.isEmpty{
            //                showAlert(alertModel: AlertModel(alertTitle: , alertMessage: NO_PHONE, alertType: .Ok))
            return
        }
        guard let number = URL(string: "tel://" + phone) else { return }
        UIApplication.shared.open(number)
    }
    @IBAction func whatsAppAction(_ sender: Any) {
        
        if self.commericalAd.PhoneNumber == "" {
            let alert = UIAlertController(title: "", message: "There is no whatsapp for this ad".localized, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }
        else {
            var index = AppDelegate.countries.firstIndex(where: {$0.id == AppDelegate.cityId}) ?? 0

            let urlWhats = "https://wa.me/\("\(AppDelegate.countries[index].code ?? "965")" + self.commericalAd.PhoneNumber)"
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
    //    /*
    //     // MARK: - Navigation
    //
    //     // In a storyboard-based application, you will often want to do a little preparation before navigation
    //     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //     // Get the new view controller using segue.destination.
    //     // Pass the selected object to the new view controller.
    //     }
    //     */
    //
    //
}
extension CommericalAdDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return commericalAd.imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! commericalCollectionViewCell
        
        cell.setData(image: commericalAd.imgArr[indexPath.row])
        return cell
    }
   
    //    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    //        self.currentIndex.text = String(indexPath.row + 1)
    //
    //    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (( UIScreen.main.bounds.size.width)/1  )
        let cellHieght = (( UIScreen.main.bounds.size.height)/1 - 200)
        
        
        print(cellWidth)
        return CGSize(width: cellWidth, height:cellHieght)
        
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()

        visibleRect.origin = sliderCollectionView.contentOffset
        visibleRect.size = sliderCollectionView.bounds.size

        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

        guard let indexPath = sliderCollectionView.indexPathForItem(at: visiblePoint) else { return }
        self.currentIndex.text = String(indexPath.row + 1)
        currentImageslider = indexPath.row
        print(indexPath)
    }
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//
//
//        behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
//    }
    
    func getAdDetails(){
        let url = "\(COMMERICAL_ADS_DETAILS)\(commericalAd.id)"
        print(url)
        let headers = HEADER_BOTH
        print(headers["Authorization"])
        
        Alamofire.request(url, method: .get, parameters: nil , encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            print(response.result.value)
            if let json = response.result.value as? NSDictionary{
                self.commericalAd = Ad(details: json as! [String : Any])
                self.sliderCollectionView.reloadData()
                self.totalItems.text = String(self.commericalAd.imgArr.count)
                
            }
        }
        
    }
    
}

