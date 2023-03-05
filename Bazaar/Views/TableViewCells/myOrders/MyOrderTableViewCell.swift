//
//  MyOrderTableViewCell.swift
//  Bazaar
//
//  Created by Amal Elgalant on 21/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class MyOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var refNumLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(order: Order){
        dateLbl.text = order.date ?? ""
        if order.paid!{
            statusLbl.text = "Paid".localized
            statusLbl.textColor = #colorLiteral(red: 0, green: 0.6642546058, blue: 0.1482077241, alpha: 1)
        }else{
            statusLbl.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)

            statusLbl.text = "Not paid".localized

        }
        quantityLbl.text = "\(order.quantity ?? 0)"
        refNumLbl.text = order.refNum ?? ""
    }

}
