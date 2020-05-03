//
//  SupportVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 1/29/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MOLH
import NVActivityIndicatorView

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
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    //Constants
    let QuestionCellId = "QuestionCell"
    
    //Variables
    var questions = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.startAnimating()
        setupView()
        setupTableView()
        loadData()
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
    
    func loadData() {
        QuestionService.instance.getQuestions { (error, questions) in
            if let questions = questions {
                self.questions = questions
                self.tableView.reloadData()
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
//                self.tableView.rowHeight = UITableView.automaticDimension;
//                self.tableView.estimatedRowHeight = 200;
            }
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toMain", sender: self)
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        if NetworkHelper.getToken() != nil {
            if QATxtField.text == "" && QETxtField.text == "" {return} else {
                guard let email = emailTxtField.text, emailTxtField.text != "" else {return}
                self.indicator.isHidden = false
                self.indicator.startAnimating()
                let QA = QATxtField.text
                let QE = QETxtField.text
                
                var parameters = [String:Any]()
                
                if QA == "" {
                    parameters = [
                        "Email" : email,
                        "QuestionEN": QE as Any
                    ]
                }
                if QE == "" {
                    parameters = [
                        "Email" : email,
                        "QuestionAR": QA as Any
                    ]
                }
                else  {
                    parameters = [
                        "Email" : email,
                        "QuestionEN": QE as Any,
                        "QuestionAR": QA as Any
                    ]
                }
                
                Alamofire.request(QUESTIONS_URL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: HEADER_BOTH).responseJSON { (response) in
                    switch response.result {
                    case .failure(let error):
                        print(error)
                    case .success(let value):
                        _ = JSON(value)
                        let alert = UIAlertController(title: "", message: "Your Messege have successfully sent".localized, preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        let when = DispatchTime.now() + 3
                        DispatchQueue.main.asyncAfter(deadline: when){
                            alert.dismiss(animated: true) {
                                self.emailTxtField.text = ""
                                self.QATxtField.text = ""
                                self.QETxtField.text = ""
                                self.indicator.stopAnimating()
                                self.indicator.isHidden = true
                            }
                        }
                        
                    }
                }
            }
            
        } else {
            let alert = UIAlertController(title: "", message: "You Should login first".localized, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 3
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension SupportVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionCellId, for: indexPath) as! QuestionCell
        cell.emailLbl.text = questions[indexPath.row].Email
        if MOLHLanguage.isArabic() {
            cell.questionLbl.text = questions[indexPath.row].QuestionAR
            cell.answerLbl.text = questions[indexPath.row].AnswerAR
        } else {
            cell.questionLbl.text = questions[indexPath.row].QuestionEN
            cell.answerLbl.text = questions[indexPath.row].AnswerEN
        }
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
