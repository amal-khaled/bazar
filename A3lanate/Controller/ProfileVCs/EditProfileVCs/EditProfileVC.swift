//
//  EditProfileVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/6/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var profileImgBtn: UIButton!
    @IBOutlet weak var cameraImg: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var changePassBtn: UIButton!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var addressTxtField: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        profileImg.addBorder(borderWidth: 2, borderColor: #colorLiteral(red: 0, green: 0.5594217181, blue: 0.3978024721, alpha: 1))
        profileImg.addCornerRadius(cornerRadius: 65)
        cameraImg.addCornerRadius(cornerRadius: 15)
        mainView.addBorder()
        mainView.addCornerRadius(cornerRadius: 30)
        editBtn.addCornerRadius(cornerRadius: 15)
        changePassBtn.addCornerRadius(cornerRadius: 15)
    }
    
    @IBAction func profileImgBtnPressed(_ sender: Any) {
    }
    
    @IBAction func editBtnPressed(_ sender: Any) {
    }
    
    @IBAction func changePassBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toChangePassVC", sender: self)
    }
}
