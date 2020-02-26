//
//  PayVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/9/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH

class FeaturesVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    
    //Constants
    let PayCellId = "PayCell"
    
    //Variables
    var features = [Feature]()
    
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
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        let payActionSheet = PayActionSheet()
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

    }
}
