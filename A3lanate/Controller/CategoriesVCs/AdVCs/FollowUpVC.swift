//
//  FollowUpVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/9/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class FollowUpVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //Constants
    let FollowUpCellId = "FollowUpCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: FollowUpCellId, bundle: nil), forCellReuseIdentifier: FollowUpCellId)
    }
}

extension FollowUpVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FollowUpCellId, for: indexPath) as! FollowUpCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}
