//
//  FavoriteVC.swift
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

class FavoriteVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var itemsNoLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    //Constants
    let FavoriteCellId = "FavoriteCell"
    
    //Variables
    var favAds = [Ad]()
    var selectedAdId: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if NetworkHelper.getToken() == nil {
            let alert = UIAlertController(title: "", message: "You Should login first".localized, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true) {
                    self.performSegue(withIdentifier: "toLoginVC", sender: self)
                }
            }
        } else {
            indicator.startAnimating()
            setupView()
            setupTableView()
            loadData()
            badgeSetup()
        }
    }
    
    func setupView() {
        self.navigationController?.navigationBar.addCornerRadius(cornerRadius: 25)
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        self.tabBarController?.tabBar.addCornerRadius(cornerRadius: 25)
        self.tabBarController?.tabBar.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: FavoriteCellId, bundle: nil), forCellReuseIdentifier: FavoriteCellId)
    }
    
    func loadData() {
        AdsService.instance.getLovedAds { (error, favAds) in
            if let favAds = favAds {
                self.favAds = favAds
                self.itemsNoLbl.text = "( \(favAds.count)" + " " + "Items".localized + " )"
                self.tableView.reloadData()
                self.badgeSetup()
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
        }
    }
    
    func badgeSetup() {
        if let tabItems = tabBarController?.tabBar.items {
            let tabItem = tabItems[3]
            tabItem.badgeValue = "\(favAds.count)"
            tabItem.badgeColor = #colorLiteral(red: 0.001686832751, green: 0.1439712048, blue: 0.4857619405, alpha: 1)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAdVC" {
            let destVC = segue.destination as! AdVC
            destVC.selectedAdId = self.selectedAdId
        }
    }
}

extension FavoriteVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favAds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCellId, for: indexPath) as! FavoriteCell
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            cell.titleLbl.text = favAds[indexPath.row].titleAr
            cell.deskLbl.text = favAds[indexPath.row].Description
            cell.priceLbl.text = "\(favAds[indexPath.row].price)" + " " + favAds[indexPath.row].cur

        } else {
            cell.titleLbl.text = favAds[indexPath.row].titleEn
            cell.deskLbl.text = favAds[indexPath.row].DescriptionEN
            cell.priceLbl.text = "\(favAds[indexPath.row].price)" + " " + favAds[indexPath.row].curEn

        }
        Alamofire.request(favAds[indexPath.row].imgUrl).responseImage { (response) in
            if let image = response.result.value {
                DispatchQueue.main.async {
                    cell.favoriteImg.image = image
                }
            }
        }
        cell.btnPressed = { [weak self] in
            AdsService.instance.favoriteAdById(Id: (self?.favAds[indexPath.row].id)!) { (success) in
                if success {
                    self?.loadData()
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedAdId = self.favAds[indexPath.row].id
        self.performSegue(withIdentifier: "toAdVC", sender: self)
    }
    
    
}
