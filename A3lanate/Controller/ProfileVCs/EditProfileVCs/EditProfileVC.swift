//
//  EditProfileVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/6/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON

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
        loadProfile()
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
    
    func loadProfile() {
        Alamofire.request(PROFILE_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER_AUTH).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let value):
                let json = JSON(value)
                if let name = json["Name"].string {
                    self.nameTxtField.text = name
                }
                if let Email = json["Email"].string {
                    self.emailTxtField.text = Email
                }
                if let Address = json["Address"].string {
                    self.addressTxtField.text = Address
                }
                if let PhoneNumber = json["PhoneNumber"].string {
                    self.phoneTxtField.text = PhoneNumber
                }
                if let image = json["ImageURL"].string {
                    Alamofire.request(image).responseImage { (response) in
                        if let image = response.result.value {
                            DispatchQueue.main.async {
                                self.profileImg.image = image
                                self.profileImg.contentMode = .scaleAspectFill
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func profileImgBtnPressed(_ sender: Any) {
    }
    
    @IBAction func editBtnPressed(_ sender: Any) {
    }
    
    @IBAction func changePassBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toChangePassVC", sender: self)
    }
}
