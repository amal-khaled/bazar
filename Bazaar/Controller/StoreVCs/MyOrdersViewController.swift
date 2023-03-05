//
//  MyOrdersViewController.swift
//  Bazaar
//
//  Created by Amal Elgalant on 22/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class MyOrdersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var orders = [Order]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        getMyOrders()

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
extension MyOrdersViewController{
    func getMyOrders(){
        OrderServices.instance.getMyOrders(completion: {
            orders in
            self.orders = orders
            self.tableView.reloadData()
        })
    }
    
}

extension MyOrdersViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyOrderTableViewCell
        cell.setData(order: orders[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Store", bundle: nil).instantiateViewController(withIdentifier: "myorderdetails") as! MyOrderDetailsViewController
        vc.order = orders[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
