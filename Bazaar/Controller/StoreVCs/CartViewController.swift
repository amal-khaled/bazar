//
//  CartViewController.swift
//  Bazaar
//
//  Created by Amal Elgalant on 19/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    @IBOutlet weak var subtotalLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var shippingCostLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        // Do any additional setup after loading the view.
    }
    @IBAction func continueAction(_ sender: Any) {
        if AppDelegate.cart.products.count > 0{
            if NetworkHelper.getToken() == nil {
                let alert = UIAlertController(title: "", message: "You Should login first".localized.localized, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                let when = DispatchTime.now() + 2
                DispatchQueue.main.asyncAfter(deadline: when){
                    alert.dismiss(animated: true, completion: {
//                        self.performSegue(withIdentifier: "toLoginVC", sender: self)
                        self.basicPresentation(storyName: "Main", segueId: "login")
})
                }
                
            }
            else{
                self.basicNavigation(storyName: "Store", segueId: "checkout")            }
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

extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDelegate.cart.products.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cart") as! CartTableViewCell
        cell.setData(product: AppDelegate.cart.products[indexPath.row])
        cell.Delegate = self
        return cell
    }
}
extension CartViewController{
    func setData(){
        self.subtotalLbl.text = "\(AppDelegate.cart.price)" + " KW".localized
        self.shippingCostLbl.text = "2" + " KW".localized
        self.totalLbl.text = "\(AppDelegate.cart.price + 2)" + " KW".localized
    }
}
extension CartViewController: CartTableViewDelegate{
    func changeQuantity() {
        setData()
        tableView.reloadData()
    }
    
    
}
