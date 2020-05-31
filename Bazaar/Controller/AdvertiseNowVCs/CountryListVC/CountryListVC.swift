//
//  CountryListVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH

class CountryListVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    var countries: [String] = ["Kuwait".localized]
    
    //Constants
    let CountryCellId = "CountryCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: CountryCellId, bundle: nil), forCellReuseIdentifier: CountryCellId)
        tableView.reloadData()
    }
    
    func setupView() {
        tableView.addBorder()
        tableView.addCornerRadius(cornerRadius: 30)
        self.upperView.addCornerRadius(cornerRadius: 25)
        self.upperView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
    }
}

extension CountryListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryCellId, for: indexPath) as! CountryCell
            cell.countryBtn.setTitle(countries[indexPath.row], for: .normal)
        cell.btnPressed = { [weak self] in
            cell.countryBtn.setImage(UIImage(named: "checked_rectangle"), for: .normal)
            AdvertiseNowVC.selectedCountry = (self?.countries[indexPath.row])!
            self?.dismiss(animated: true, completion: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CountryCell
        cell.countryBtn.setImage(UIImage(named: "checked_rectangle"), for: .normal)
        AdvertiseNowVC.selectedCountry = countries[indexPath.row]
        self.dismiss(animated: true, completion: nil)
    }
}
