//
//  PayVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/9/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH
import Alamofire
import AlamofireImage
import SwiftyJSON

class FeaturesVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    
    //Constants
    let PayCellId = "PayCell"
    
    //Variables
    var features = [Feature]()
    var featuresIds = [[String:Int]]()
    var adId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
    }
    
    func setupView() {
        nextBtn.addCornerRadius(cornerRadius: 25)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: PayCellId, bundle: nil), forCellReuseIdentifier: PayCellId)
    }
    
    func loadData() {
        FeaturesService.instance.getFeatures { (error, features) in
            if let features = features {
                self.features = features
                self.tableView.reloadData()
            }
        }
    }
    
    func addFeatures(completion: @escaping CompletionHandler) {
        if featuresIds.count == 0 {
            return
        } else {
        let parameters : [String : Any] = [
            "Flag": 0,
            "AdId": adId,
            "Features": featuresIds
            ]
            print(parameters)
        Alamofire.request(ADD_FEATURES_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HEADER_JSON).responseString { (response) in
            if response.result.error == nil {
            } else {
                debugPrint(response.result.error as Any)
            }
        }
        }
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        addFeatures { (success) in
            if success {
            }
        }
        let payActionSheet = PayActionSheet()
        payActionSheet.adId = self.adId
        payActionSheet.modalPresentationStyle = .custom
        present(payActionSheet, animated: true, completion: nil)
    }
}

extension FeaturesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return features.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PayCellId, for: indexPath) as! PayCell
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            cell.featureTitleLbl.text = features[indexPath.row].FeatureNameAR
            cell.featureDescLbl.text = features[indexPath.row].FeatureDescription
        } else {
            cell.featureTitleLbl.text = features[indexPath.row].FeatureNameEN
            cell.featureDescLbl.text = features[indexPath.row].FeatureDescriptionEN
        }
        cell.currencyLbl.text = "KWD".localized
        cell.featurePriceLbl.text = "\(features[indexPath.row].FeaturePrice)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PayCell
        cell.radioBtn.setImage(UIImage(named: "checked_rectangle"), for: .normal)
        self.featuresIds.append(["FeatureId" : features[indexPath.row].FeatureId])
    }
}
