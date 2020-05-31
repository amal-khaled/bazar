//
//  MyAdsVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH
import Alamofire
import AlamofireImage
import NVActivityIndicatorView

class MyAdsVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var openedBtn: UIButton!
    @IBOutlet weak var closedBtn: UIButton!
    @IBOutlet weak var thirdBtn: UIButton!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lineViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    //Constants
    let MyAdsCellId = "MyAdsCell"
    
    //Variables
    var ads = [Ad]()
    var selectedAdId: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        setupView()
        setubTableView()
        loadData()
    }
    
    func setupView() {
        containerView.addCornerRadius(cornerRadius: 20)
    }
    
    func setubTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: MyAdsCellId, bundle: nil), forCellReuseIdentifier: MyAdsCellId)
    }
    
    func loadData() {
        AdsService.instance.getOpenedAds { (error, openedAds) in
            if let openedAds = openedAds {
                self.ads = openedAds
                self.tableView.reloadData()
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAdVC" {
            let destVC = segue.destination as! AdVC
            destVC.selectedAdId = self.selectedAdId
        }
    }
    
    @IBAction func openedBtnPressed(_ sender: Any) {
        lineViewConstraint.constant = 0
        indicator.isHidden = false
        indicator.startAnimating()
        AdsService.instance.getOpenedAds { (error, openedAds) in
            if let openedAds = openedAds {
                self.ads = openedAds
                self.tableView.reloadData()
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
        }
    }
    
    @IBAction func closedBtnPressed(_ sender: Any) {
        if MOLHLanguage.isArabic() {
        lineViewConstraint.constant = -lineView.frame.width
        } else {
            lineViewConstraint.constant = lineView.frame.width
        }
        indicator.isHidden = false
        indicator.startAnimating()
        AdsService.instance.getClosedAds { (error, closedAds) in
            if let closedAds = closedAds {
                self.ads = closedAds
                self.tableView.reloadData()
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
        }
    }
    
    @IBAction func thirdBtnPressed(_ sender: Any) {
        if MOLHLanguage.isArabic() {
        lineViewConstraint.constant = -lineView.frame.width * 2
        } else {
            lineViewConstraint.constant = lineView.frame.width * 2
        }
        indicator.isHidden = false
        indicator.startAnimating()
        AdsService.instance.getUnpaidAds { (error, unpaidAds) in
            if let unpaidAds = unpaidAds {
                self.ads = unpaidAds
                self.tableView.reloadData()
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
        }
    }
}

extension MyAdsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyAdsCellId, for: indexPath) as! MyAdsCell
        if MOLHLanguage.isArabic() {
            cell.adName.text = ads[indexPath.row].titleAr
        } else {
            cell.adName.text = ads[indexPath.row].titleEn
        }
        cell.adPrice.text = "\(ads[indexPath.row].price)" + " " + "KWD".localized
        Alamofire.request(ads[indexPath.row].imgUrl).responseImage { (response) in
            if let image = response.result.value {
                DispatchQueue.main.async {
                    cell.adImg.image = image
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 201
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedAdId = ads[indexPath.row].id
        performSegue(withIdentifier: "toAdVC", sender: self)
    }
}
