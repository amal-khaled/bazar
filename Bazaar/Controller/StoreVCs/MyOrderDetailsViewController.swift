//
//  MyOrderDetailsViewController.swift
//  Bazaar
//
//  Created by Amal Elgalant on 22/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class MyOrderDetailsViewController: UIViewController {
    @IBOutlet weak var refNumLbl: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var orderStatusLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var tableViewHieghtConstrain: NSLayoutConstraint!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var areaLbl: UILabel!
    @IBOutlet weak var distincitLbl: UILabel!
    @IBOutlet weak var streetLbl: UILabel!

    @IBOutlet weak var noteLbl: UILabel!
    @IBOutlet weak var flatNumberLbl: UILabel!
    @IBOutlet weak var buildingNumber: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelBtn: UIButton!

    var order = Order()
    
    var tableViewHeight: CGFloat {
        tableView.layoutIfNeeded()

        return tableView.contentSize.height
    }
    override func viewDidLoad() {
        super.viewDidLoad()
setData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cencelOrderAction(_ sender: Any) {
        OrderServices.instance.cencelOrder(completion: {
            check in
            if check{
                
                self.navigationController?.popViewController(animated: true)
            }
        }, orderId: self.order.id ?? 0)
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
extension MyOrderDetailsViewController{
    func setData(){
        dateLbl.text = order.date ?? ""
        if order.paid!{
            orderStatusLbl.text = "Paid".localized
            orderStatusLbl.textColor = #colorLiteral(red: 0, green: 0.6642546058, blue: 0.1482077241, alpha: 1)
            cancelBtn.isHidden = true
        }else{
            orderStatusLbl.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            cancelBtn.isHidden = false

            orderStatusLbl.text = "Not paid".localized

        }
        quantityLbl.text = "\(order.quantity ?? 0)"
        refNumLbl.text = order.refNum ?? ""
        
        nameLbl.text = order.name
        emailLbl.text = order.email
        phoneLbl.text = order.phone
        countryLbl.text = order.country
        cityLbl.text = order.city
        areaLbl.text = order.area
        distincitLbl.text = order.distinct
        streetLbl.text = order.street
        buildingNumber.text = order.buildingNumber
        flatNumberLbl.text = order.falt
        noteLbl.text = order.note
        noteLbl.sizeToFit()
        tableViewHieghtConstrain.constant = tableViewHeight
        self.updateViewConstraints()
        
    }
}
extension MyOrderDetailsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.products!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyOrderProductTableViewCell
        cell.setData(product: order.products![indexPath.row])
        return cell
    }
}
