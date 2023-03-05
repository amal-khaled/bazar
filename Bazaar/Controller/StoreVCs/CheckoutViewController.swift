//
//  CheckoutViewController.swift
//  Bazaar
//
//  Created by Amal Elgalant on 19/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    
    @IBOutlet weak var areaTF: UITextField!
    @IBOutlet weak var distinctTF: UITextField!
    
    @IBOutlet weak var buildingNumberTF: UITextField!
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var flatTF: UITextField!
    
    @IBOutlet weak var commentTV: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func continueBtnAction(_ sender: Any) {
        if nameTF.text?.count == 0{
            createErrorAlert(msg: "enter your name", vc: self)
            return
        }
        if emailTF.text?.count == 0{
            createErrorAlert(msg: "enter your email", vc: self)
            return
        }
        if phoneTF.text?.count == 0{
            createErrorAlert(msg: "enter your phone", vc: self)
            return
        }
        if countryTF.text?.count == 0{
            createErrorAlert(msg: "enter your country", vc: self)
            return
        }
        if cityTF.text?.count == 0{
            createErrorAlert(msg: "enter your city", vc: self)
            return
        }
        if areaTF.text?.count == 0{
            createErrorAlert(msg: "enter your area", vc: self)
            return
        }
        if distinctTF.text?.count == 0{
            createErrorAlert(msg: "enter your distinct", vc: self)
            return
        }
        if streetTF.text?.count == 0{
            createErrorAlert(msg: "enter your street", vc: self)
            return
        }
        if buildingNumberTF.text?.count == 0{
            createErrorAlert(msg: "enter building number", vc: self)
            return
        }
        if flatTF.text?.count == 0{
            createErrorAlert(msg: "enter your flat number", vc: self)
            return
        }
        var order = Order();
        order.name = nameTF.text!
        order.email = emailTF.text!
        order.phone = phoneTF.text!
        order.country = countryTF.text!
        order.city = cityTF.text!
        order.distinct = distinctTF.text!
        order.street = streetTF.text!
        order.buildingNumber = buildingNumberTF.text!
        order.falt = flatTF.text!
        order.note = commentTV.text!

        order.area = areaTF.text!
        order.products = AppDelegate.cart.products
        OrderServices.instance.saveOrder(completion: { order in
            AppDelegate.cart = Cart()
            AppDelegate.cart.removeCart()
            print(order.id ?? 0)
            let vc = UIStoryboard(name: "Store", bundle: nil).instantiateViewController(withIdentifier: "payment") as! PaymentListViewController
            vc.orderId = order.id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
            
        }, order: order)
        
        
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
