//
//  FavoriteCell.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
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
    
    //Variables
    var btnPressed: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        favoriteImg.addCornerRadius(cornerRadius: 20)
    }
    
    @IBAction func likeBtnPressed(_ sender: Any) {
        btnPressed?()
    }
}
