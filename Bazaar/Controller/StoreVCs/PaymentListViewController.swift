//
//  PaymentListViewController.swift
//  Bazaar
//
//  Created by Amal Elgalant on 21/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import Alamofire
import MOLH
import SwiftyJSON

class PaymentListViewController: UIViewController {
    var paymentList = [StorePaymentMethod]()
    @IBOutlet weak var tableView: UITableView!
    
    var orderId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        getPaymentList()
        // Do any additional setup after loading the view.
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
extension PaymentListViewController{
    func getPaymentList(){
        OrderServices.instance.getPaymentList(completion: { paymentList in
            self.paymentList = paymentList
            self.tableView.reloadData()
        }, orderId: orderId)
    }
}
extension PaymentListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PaymentTableViewCell
        cell.setData(payment: paymentList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var parameters = [
            "OrderId": orderId,
            "PaymentMethodId": paymentList[indexPath.row].PaymentMethodId,
            "lang": MOLHLanguage.currentAppleLanguage()] as [String : Any]
        
        Alamofire.request(PAYMENT_LINK, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: HEADER_BOTH).responseString { (response) in
            if response.result.error == nil {
                let value = response.result.value
                let json = JSON(value as Any)
                if let url = json.string {
                    var ur: String = ""
                    ur = url
                    ur.removeFirst()
                    ur.removeLast()
                    UIApplication.shared.open(URL(string: ur.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!, options: [:], completionHandler: nil)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {

                    self.navigationController?.popToRootViewController(animated: true)
                    })
                }
            } else {
                debugPrint(response.result.error as Any)
            }
        }
    }
}
