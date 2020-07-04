//
//  PackagePaymentMethodsVC.swift
//  Bazaar
//
//  Created by Mahmoud Elshakoushy on 6/25/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//


import UIKit
import MOLH
import Alamofire
import AlamofireImage
import SwiftyJSON

class PackagePaymentMethodsVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    //Constants
    let PackageCellId = "PackageCell"
    
    //Variables
    var paymentMethods = [PaymentMethod]()
    var packageId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        loadData()
    }
    
    func setupView() {
        self.upperView.addCornerRadius(cornerRadius: 25)
        self.upperView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        closeBtn.addCornerRadius(cornerRadius: 15)
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: PackageCellId, bundle: nil), forCellReuseIdentifier: PackageCellId)
    }
    
    func loadData() {
        PaymentMethodService.instance.getPaymentMethodsForPackage(package: packageId) { (erroe, paymentMethods) in
            if let paymentMethods = paymentMethods {
                self.paymentMethods = paymentMethods
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension PackagePaymentMethodsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.paymentMethods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PackageCellId, for: indexPath) as! PackageCell
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            cell.titleLbl.text = paymentMethods[indexPath.row].PaymentMethodAr
        } else {
            cell.titleLbl.text = paymentMethods[indexPath.row].PaymentMethodEn
        }
        cell.priceLbl.text = ""
        Alamofire.request(paymentMethods[indexPath.row].ImageUrl).responseImage { (response) in
            if let image = response.result.value {
                DispatchQueue.main.async {
                    cell.iconImg.image = image
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var parameters = [String: Any]()
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            parameters = [
                "PackageId" : packageId,
                "Lang": "ar",
                "PaymentMethodId" : paymentMethods[indexPath.row].PaymentMethodId
            ]
        } else {
            parameters = [
                "PackageId" : packageId,
                "Lang": "en",
                "PaymentMethodId" : paymentMethods[indexPath.row].PaymentMethodId
            ]
        }
        
        Alamofire.request(EXECUTEPAYMENTMETHODFORPACKAGE_URL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: HEADER_BOTH).responseString { (response) in
            if response.result.error == nil {
                let value = response.result.value
                let json = JSON(value as Any)
                if let url = json.string {
                    var ur: String = ""
                    ur = url
                    ur.removeFirst()
                    ur.removeLast()
                    UIApplication.shared.open(URL(string: ur.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!, options: [:], completionHandler: nil)
                }
            } else {
                debugPrint(response.result.error as Any)
            }
        }
    }
}
