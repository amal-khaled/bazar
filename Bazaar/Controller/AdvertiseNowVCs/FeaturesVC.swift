//
//  PayVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH
import Alamofire
import AlamofireImage
import SwiftyJSON
import NVActivityIndicatorView

class FeaturesVC: UIViewController {
    
    @IBOutlet weak var nextBtn: UIButton!
    //Outlets
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
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
        indicator.startAnimating()
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
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
        }
    }
    
    func addFeatures(completion: @escaping CompletionHandler) {
        if featuresIds.count == 0 {
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            let payActionSheet = PayActionSheet()
            payActionSheet.adId = self.adId
            payActionSheet.modalPresentationStyle = .custom
            self.present(payActionSheet, animated: true, completion: nil)
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
                completion(true)
            } else {
                completion(false)

                debugPrint(response.result.error as Any)
            }
        }
        }
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        indicator.isHidden = false
        indicator.startAnimating()
        addFeatures { (success) in
            if success {
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                let payActionSheet = PayActionSheet()
                payActionSheet.adId = self.adId
                payActionSheet.modalPresentationStyle = .custom
                self.present(payActionSheet, animated: true, completion: nil)
            }
        }
       
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
            cell.currencyLbl.text = features[indexPath.row].currencyAr

        } else {
            cell.featureTitleLbl.text = features[indexPath.row].FeatureNameEN
            cell.featureDescLbl.text = features[indexPath.row].FeatureDescriptionEN
            cell.currencyLbl.text = features[indexPath.row].currencyEn

        }
        cell.featurePriceLbl.text = "\(features[indexPath.row].FeaturePrice)"
        cell.btnPressed = { [weak self] in
            if cell.radioBtn.image(for: .normal) == UIImage(named: "unchecked_rectangle") {
                cell.radioBtn.setImage(UIImage(named: "checked_rectangle"), for: .normal)
                self?.featuresIds.append(["FeatureId" : (self?.features[indexPath.row].FeatureId)!])
            } else {
                cell.radioBtn.setImage(UIImage(named: "unchecked_rectangle"), for: .normal)
                self?.featuresIds.removeLast()
            }
            if self?.featuresIds.count == 0{
                self?.nextBtn.setTitle("Skip".localized, for: .normal)
            }else{
                self?.nextBtn.setTitle("Next".localized, for: .normal)

            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PayCell
        if cell.radioBtn.image(for: .normal) == UIImage(named: "unchecked_rectangle") {
            cell.radioBtn.setImage(UIImage(named: "checked_rectangle"), for: .normal)
            self.featuresIds.append(["FeatureId" : (self.features[indexPath.row].FeatureId)])
        } else {
            cell.radioBtn.setImage(UIImage(named: "unchecked_rectangle"), for: .normal)
            self.featuresIds.removeLast()
        }
        if featuresIds.count == 0{
            nextBtn.setTitle("Skip".localized, for: .normal)
        }else{
            nextBtn.setTitle("Next".localized, for: .normal)

        }
    }
}
