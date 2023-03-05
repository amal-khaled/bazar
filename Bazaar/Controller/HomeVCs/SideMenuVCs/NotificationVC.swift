//
//  notificationVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH
import NVActivityIndicatorView

class NotificationVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    //Constants
    let NotificationCellId = "NotificationCell"
    
    //Variables
    var notifications = [NotificationN]()
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        setupView()
        setupTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
        
    }
    
    func setupView() {
        self.navigationController?.navigationBar.addCornerRadius(cornerRadius: 25)
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: NotificationCellId, bundle: nil), forCellReuseIdentifier: NotificationCellId)
    }
    
    func loadData() {
        NotificationService.instance.getNotifications { (error, notifications) in
            if let notifications = notifications {
                self.notifications = notifications
                print(notifications)
                self.tableView.reloadData()
                
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toMain", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "advc" {
            let destVC = segue.destination as! AdVC
            destVC.selectedAdId = self.notifications[selectedIndex].AdId
        }else if segue.identifier == "com_id" {
            let destVC = segue.destination as! CommericalAdDetailsViewController
            destVC.commericalAd.id = self.notifications[selectedIndex].CommericalAdId
        }//com_id
        
    }
}

extension NotificationVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCellId, for: indexPath) as! NotificationCell
        if MOLHLanguage.isArabic() {
            cell.nameLbl.text = notifications[indexPath.row].Title
            cell.bodyWebview.text = notifications[indexPath.row].Body
            cell.bodyWebview.sizeToFit()
            cell.bodyWebview.layoutIfNeeded()
        } else {
            cell.nameLbl.text = notifications[indexPath.row].TitleEN
            cell.bodyWebview.text = notifications[indexPath.row].BodyEN
            cell.bodyWebview.sizeToFit()
            cell.bodyWebview.layoutIfNeeded()
            
            
        }
        if MOLHLanguage.currentAppleLanguage() == "en"{
            cell.bodyWebview.textAlignment = .left
            
        }else{
            cell.bodyWebview.textAlignment = .right
            
        }
        cell.dateLbl.text = notifications[indexPath.row].Date
        //        cell.setupView()
//        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        advc
        self.selectedIndex = indexPath.row
        print(notifications[indexPath.row].type)
        if notifications[indexPath.row].AdId != 0{
            self.performSegue(withIdentifier: "advc", sender: self)
        }else if notifications[indexPath.row].CommericalAdId != 0{
            self.performSegue(withIdentifier: "com_id", sender: self)
        }else if notifications[indexPath.row].type == 1{
            self.performSegue(withIdentifier: "balance", sender: self)
        }
        //balance
    }
}
