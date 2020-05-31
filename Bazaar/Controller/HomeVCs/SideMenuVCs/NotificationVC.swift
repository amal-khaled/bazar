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
        } else {
            cell.nameLbl.text = notifications[indexPath.row].TitleEN
        }
        cell.dateLbl.text = notifications[indexPath.row].Date
        return cell
    }
}
