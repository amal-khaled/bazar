//
//  BuyPackageVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/29/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH
import Alamofire
import SwiftyJSON

class BuyPackageVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeBtn: UIButton!
    
    //Constants
    let PackageCellId = "PackageCell"
    
    //Variables
    var packages = [Package]()
    
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
        PackagesService.instance.getPackages { (error, packages) in
            if let packages = packages {
                self.packages = packages
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension BuyPackageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.packages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PackageCellId, for: indexPath) as! PackageCell
        cell.titleLbl.text = packages[indexPath.row].PackageName
        cell.priceLbl.text = "\(packages[indexPath.row].PackagePrice)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var parameters = [String: Any]()
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            parameters = [
                "PackageId" : packages[indexPath.row].PackageId,
               "Lang": "ar",
               ]
        } else {
            parameters = [
                "PackageId" : packages[indexPath.row].PackageId,
               "Lang": "en",
               ]
        }
        
        Alamofire.request(PAY_PACKAGE_URL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: HEADER_BOTH).responseString { (response) in
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
