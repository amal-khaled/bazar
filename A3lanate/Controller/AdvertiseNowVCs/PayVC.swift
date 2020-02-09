//
//  PayVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/9/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class PayVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    
    //Constants
    let PayCellId = "PayCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
    }
    
    func setupView() {
        nextBtn.addCornerRadius(cornerRadius: 25)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: PayCellId, bundle: nil), forCellReuseIdentifier: PayCellId)
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        let payActionSheet = PayActionSheet()
        payActionSheet.modalPresentationStyle = .custom
        present(payActionSheet, animated: true, completion: nil)
    }
}

extension PayVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PayCellId, for: indexPath) as! PayCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
