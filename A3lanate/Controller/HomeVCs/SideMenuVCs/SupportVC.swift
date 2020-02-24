//
//  SupportVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 1/29/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class SupportVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var questionsView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var QATxtField: UITextField!
    @IBOutlet weak var QETxtField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    //Constants
    let QuestionCellId = "QuestionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
    }
    
    func setupView() {
        self.navigationController?.navigationBar.addCornerRadius(cornerRadius: 25)
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        questionsView.addBorder()
        questionsView.addCornerRadius(cornerRadius: 30)
        secondView.addBorder()
        secondView.addCornerRadius(cornerRadius: 30)
        emailTxtField.addBorder()
        emailTxtField.addCornerRadius(cornerRadius: 16)
        QATxtField.addBorder()
        QATxtField.addCornerRadius(cornerRadius: 16)
        QETxtField.addBorder()
        QETxtField.addCornerRadius(cornerRadius: 16)
        sendBtn.addCornerRadius(cornerRadius: 16)
        emailTxtField.delegate = self
        QATxtField.delegate = self
        QETxtField.delegate = self
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: QuestionCellId, bundle: nil), forCellReuseIdentifier: QuestionCellId)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toMain", sender: self)
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
    }
}

extension SupportVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionCellId, for: indexPath) as! QuestionCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
}

extension SupportVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
