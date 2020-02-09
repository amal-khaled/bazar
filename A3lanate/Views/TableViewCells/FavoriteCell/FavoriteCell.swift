//
//  FavoriteCell.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/6/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var favoriteImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var deskLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        favoriteImg.addCornerRadius(cornerRadius: 20)
    }
    
    @IBAction func likeBtnPressed(_ sender: Any) {
    }
}
