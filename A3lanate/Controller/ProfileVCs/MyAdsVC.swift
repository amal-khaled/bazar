//
//  MyAdsVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/6/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class MyAdsVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var openedBtn: UIButton!
    @IBOutlet weak var closedBtn: UIButton!
    @IBOutlet weak var thirdBtn: UIButton!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //Constants
    let MyAdsCellId = "MyAdsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setubTableView()
    }
    
    func setupView() {
        containerView.addCornerRadius(cornerRadius: 20)
    }
    
    func setubTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: MyAdsCellId, bundle: nil), forCellReuseIdentifier: MyAdsCellId)
    }
    
    @IBAction func openedBtnPressed(_ sender: Any) {
    }
    
    @IBAction func closedBtnPressed(_ sender: Any) {
    }
    
    @IBAction func thirdBtnPressed(_ sender: Any) {
    }
}

extension MyAdsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyAdsCellId, for: indexPath) as! MyAdsCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 201
    }
}
