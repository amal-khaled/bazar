//
//  QuestionCell.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var answerLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        mainView.addBorder()
        mainView.addCornerRadius(cornerRadius: 20)
    }
}
