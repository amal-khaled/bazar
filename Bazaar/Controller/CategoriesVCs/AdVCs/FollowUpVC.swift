//
//  FollowUpVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FollowUpVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //Constants
    let FollowUpCellId = "FollowUpCell"
    
    //Variables
    var selectedAdId: Int = 0
    var array = [Int]()
    var titleArray = ["Views".localized,"Phone Calls".localized,"Likes".localized,"Whatsapp".localized]
    var imgArray = ["view","call","likeG","whatsapp"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: FollowUpCellId, bundle: nil), forCellReuseIdentifier: FollowUpCellId)
    }
    
    func loadData() {
        Alamofire.request("\(FOLLOWUP_AD_BY_ID_URL)\(selectedAdId)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER_BOTH).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let value):
                let json = JSON(value)
                print(json)
                let TotalAdViews = json["TotalAdViews"].int ?? 0
                let TotalAdCalls = json["TotalAdCalls"].int ?? 0
                let TotalAdLikes = json["TotalAdLikes"].int ?? 0
                let TotalWhatsappAdCalls = json["TotalWhatsappAdCalls"].int ?? 0
                self.array.append(TotalAdViews)
                self.array.append(TotalAdCalls)
                self.array.append(TotalAdLikes)
                self.array.append(TotalWhatsappAdCalls)
                self.setupTableView()
                self.tableView.reloadData()
            }
        }
    }
}

extension FollowUpVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FollowUpCellId, for: indexPath) as! FollowUpCell
        cell.noLbl.text = "\(array[indexPath.row])"
        cell.titleLbl.text = "\(titleArray[indexPath.row])"
        cell.iconImg.image = UIImage(named: imgArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}
