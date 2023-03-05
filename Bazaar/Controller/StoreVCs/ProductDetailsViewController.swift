//
//  ProductDetailsViewController.swift
//  Bazaar
//
//  Created by Amal Elgalant on 14/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import ImageSlideshow
import MOLH
import SimpleImageViewer

class ProductDetailsViewController: UIViewController {
    @IBOutlet weak var imageSlideshow: ImageSlideshow!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    var sliderAlamoSource = [AlamofireSource]()
    
    @IBOutlet weak var quantityPopLbl: UILabel!
    @IBOutlet weak var addtocartView: UIView!
    var product = Product()
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func increaseBtnAction(_ sender: Any) {
        var totalAvailable = product.stock
        
        if let index = AppDelegate.cart.products.firstIndex(where: {$0.id == product.id}){
            totalAvailable =  (product.stock ?? 0) - (AppDelegate.cart.products[index].quanityInsideCart! + product.quanityInsideCart! )
        }else{
            totalAvailable = (product.stock ?? 0) -  product.quanityInsideCart!
        }
        if (totalAvailable ?? 0) > 0 {
            
            product.quanityInsideCart! += 1
            
            quantityLbl.text = "\(product.quanityInsideCart ?? 0)"
        }else{
            createErrorAlert(msg: "not available in the stock".localized, vc: self)
        }
    }
    
    @IBAction func decreaseBtnAction(_ sender: Any) {
        if product.quanityInsideCart!  > 1{
            product.quanityInsideCart! -= 1
            quantityLbl.text = "\(product.quanityInsideCart ?? 0)"
        }
        
    }
    @IBAction func addToCart(_ sender: Any) {
         
        if let index = AppDelegate.cart.products.firstIndex(where: {$0.id == product.id}){
         
            if (product.stock ?? 0) > (AppDelegate.cart.products[index].quanityInsideCart!) {
                quantityPopLbl.text = quantityLbl.text

                AppDelegate.cart.products[index].quanityInsideCart! += product.quanityInsideCart!
                
                AppDelegate.cart.price += Double(product.quanityInsideCart!) * product.price!
            }else{
                quantityPopLbl.text = "0"

                createErrorAlert(msg: "not available in the stock".localized, vc: self)
            }
            
        }else{
            quantityPopLbl.text = quantityLbl.text
           
            AppDelegate.cart.products.append(product)
            AppDelegate.cart.price += Double(product.quanityInsideCart!) * product.price!

        }
        AppDelegate.cart.saveCart()
        addtocartView.isHidden = false
        
    }
    @IBAction func closeBtnAction(_ sender: Any) {
        addtocartView.isHidden = true

    }
   
    @IBAction func paymentAction(_ sender: Any) {
        //cart
        let vc = UIStoryboard(name: "Store", bundle: nil).instantiateViewController(withIdentifier: "cart") as! CartViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
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
extension ProductDetailsViewController{
    
    func setData(){
        slideShowSetup()

        if MOLHLanguage.currentAppleLanguage() == "ar"{
            self.nameLbl.text = product.name
            self.descriptionLbl.text = product.description
        }else{
            self.nameLbl.text = product.nameEn
            self.descriptionLbl.text = product.descriptionEn
        }
        self.priceLbl.text = String(product.price ?? 0.00) + " KD".localized
        self.descriptionLbl.sizeToFit()
        self.product.quanityInsideCart = 1
        
    }
    func slideShowSetup() {

        for i in 0..<(product.image?.count ?? 0) {
            self.sliderAlamoSource.append(AlamofireSource(urlString: String(describing: product.image![i].url ?? ""))!)
        }
        imageSlideshow.setImageInputs(self.sliderAlamoSource)
        imageSlideshow.slideshowInterval = 3.0
        imageSlideshow.zoomEnabled = true
        
        imageSlideshow.contentScaleMode = .scaleToFill
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        imageSlideshow.addGestureRecognizer(gestureRecognizer)
        
    }
    @objc func didTap(){
        if product.image!.count > 0 {
////            self.selectedAdId = product.image[imageSlideshow.currentPage].
//
////            self.performSegue(withIdentifier: "toAdVC", sender: self)
//            let configuration = ImageViewerConfiguration { config in
////                config.imageView = someImageView
//            }
//
//            let imageViewerController = ImageViewerController(configuration: configuration)
//
//            present(imageViewerController, animated: true)
            imageSlideshow.presentFullScreenController(from: self)

        }
    }
}
