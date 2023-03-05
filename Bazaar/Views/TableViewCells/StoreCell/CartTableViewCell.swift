//
//  CartTableViewCell.swift
//  Bazaar
//
//  Created by Amal Elgalant on 19/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import SDWebImage
import MOLH

public protocol CartTableViewDelegate: class {
    func changeQuantity()
   
    
}

class CartTableViewCell: UITableViewCell {
    open weak var Delegate: CartTableViewDelegate?

    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var btnQuantityLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var pImageView: UIImageView!
    var product = Product()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func removeAction(_ sender: Any) {
        if let index = AppDelegate.cart.products.firstIndex(where: {$0.id == product.id}){
        AppDelegate.cart.price -= product.price! * Double(product.quanityInsideCart ?? 1)
        
        
            AppDelegate.cart.products.remove(at: index)
        AppDelegate.cart.saveCart()
        Delegate?.changeQuantity()
        }

    }
    @IBAction func increaseQuantityAction(_ sender: Any) {
        var totalAvailable = product.stock
        if let index = AppDelegate.cart.products.firstIndex(where: {$0.id == product.id}){
            totalAvailable =  (product.stock ?? 0) - (AppDelegate.cart.products[index].quanityInsideCart ?? 1 )
            
            if (totalAvailable ?? 0) > 0 {
                
                product.quanityInsideCart! += 1
                AppDelegate.cart.products[index].quanityInsideCart = product.quanityInsideCart
                quantityLbl.text = "quantity: " + "\(product.quanityInsideCart ?? 0)"
                btnQuantityLbl.text = "\(product.quanityInsideCart ?? 0)"
                AppDelegate.cart.price += product.price!

                AppDelegate.cart.saveCart()

                
            }
        }
        Delegate?.changeQuantity()
    }
    @IBAction func decreaseQuantityAction(_ sender: Any) {
        if product.quanityInsideCart!  > 1{
            product.quanityInsideCart! -= 1
            
            if let index = AppDelegate.cart.products.firstIndex(where: {$0.id == product.id}){
                
                AppDelegate.cart.products[index].quanityInsideCart = product.quanityInsideCart
                quantityLbl.text = "quantity: " + "\(product.quanityInsideCart ?? 0 )"
                btnQuantityLbl.text = "\(product.quanityInsideCart ?? 0)"
                AppDelegate.cart.price -= product.price!

                AppDelegate.cart.saveCart()
                
            }
            
        }
        Delegate?.changeQuantity()

    }
    
    func setData(product: Product){
        self.product = product
        quantityLbl.text = "quantity: ".localized + "\(product.quanityInsideCart ?? 0)"
        priceLbl.text = "\(product.price ?? 0.00)" + " DK".localized
        btnQuantityLbl.text = "\(product.quanityInsideCart ?? 0)"
        if MOLHLanguage.currentAppleLanguage() == "ar"{
            self.nameLbl.text = product.name
        }else{
            self.nameLbl.text = product.nameEn
        }
        pImageView.sd_setImage(with: URL(string: product.image![0].url!), placeholderImage: #imageLiteral(resourceName: "learning"))
    }
    
}
