//
//  EditProfileVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import iOSDropDown

class EditProfileVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var profileImgBtn: UIButton!
    @IBOutlet weak var cameraImg: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var addressTxtField: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    @IBOutlet weak var countryDropDwon: DropDown!
    
    @IBOutlet weak var regionDropDwon: DropDown!
    @IBOutlet weak var cityDropDwon: DropDown!
    
    @IBOutlet weak var bioTextView: UITextView!
    
    
    
    var cityId = 0
    var cityCount = 0
    //Variables
    var pickerImage: UIImage? {
        didSet {
            guard let image = pickerImage else {return}
            self.profileImg.image = image
            UPLOD()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
//        self.codeTF.textAlignment = NSTextAlignment.left
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        indicator.startAnimating()
        loadProfile()
    }
    
    func setupView() {
        profileImg.addBorder(borderWidth: 4, borderColor: #colorLiteral(red: 0.932130754, green: 0.6688258052, blue: 0, alpha: 1))
        profileImg.addCornerRadius(cornerRadius: 50)
        // cameraImg.addCornerRadius(cornerRadius: 15)
        //  mainView.addBorder()
        //  mainView.addCornerRadius(cornerRadius: 30)
        editBtn.addCornerRadius(cornerRadius: 15)
        nameTxtField.delegate = self
        emailTxtField.delegate = self
        addressTxtField.delegate = self
        phoneTxtField.delegate = self
        
        countryDropDwon.text = "choose Country"
        countryDropDwon.optionArray = ["Option 1", "Option 2", "Option 3","Option 4", "Option 5","Option 6", "Option 7","Option 8", "Option 9"]
        countryDropDwon.optionIds = [1,23,54,22]
        countryDropDwon.optionImageArray = ["location","location","location","location"]

        countryDropDwon.didSelect{(selectedText , index ,id) in
            print("Selected String: \(selectedText) \n index: \(index)")
            self.countryDropDwon.text = "\(selectedText)"
        }
        regionDropDwon.text = "Region"
        regionDropDwon.optionArray = ["Option 1", "Option 2", "Option 3","Option 4", "Option 5","Option 6", "Option 7","Option 8", "Option 9"]
        regionDropDwon.optionIds = [1,23,54,22]

        regionDropDwon.didSelect{(selectedText , index ,id) in
            print("Selected String: \(selectedText) \n index: \(index)")
            self.regionDropDwon.text = "\(selectedText)"
        }
        cityDropDwon.text = "City"
        cityDropDwon.optionArray = ["Option 1", "Option 2", "Option 3","Option 4", "Option 5","Option 6", "Option 7","Option 8", "Option 9", "Option 10","Option 11", "Option 12","Option 13", "Option 14"]
        cityDropDwon.optionIds = [1,23,54,22,12,14,6,6,9,8,8,51,31,65,95]

        cityDropDwon.didSelect{(selectedText , index ,id) in
            print("Selected String: \(selectedText) \n index: \(index)")
            self.cityDropDwon.text = "\(selectedText)"
        }
        
        
    }
    
    func loadProfile() {
        Alamofire.request(PROFILE_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HEADER_AUTH).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let value):
                let json = JSON(value)
                print(value)
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
                if let city = json["City"].dictionary {
//                    self..text = PhoneNumber
                   // self.codeTF.text = city["Code"]?.string
                    self.cityId = city["CityId"]?.int ?? 0
                    self.cityCount = city["PhoneNumberNo"]?.int ?? 0
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
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
        }
    }
    
    func UPLOD() {
        //Parameter HERE
        let parameters = ["file":"value"]
        //Header HERE
        let headers = HEADER_BOTH
        let image = self.pickerImage
        let imgData = image!.jpegData(compressionQuality: 0.7)!
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "file",fileName: "furkan.png" , mimeType: "image/png")
            
            for (key, value) in parameters
            {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, usingThreshold:UInt64.init(),
           to: USER_IMAGE_URL,
           method: .post,
           headers: headers,
           encodingCompletion: { (result) in
            
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                }
                break
            case .failure(let encodingError):
                print("the error is  : \(encodingError.localizedDescription)")
                break
            }
        })
    }
    
    @IBAction func profileImgBtnPressed(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func editBtnPressed(_ sender: Any) {
        guard let name = nameTxtField.text, nameTxtField.text != "" else {return}
        guard let email = emailTxtField.text, emailTxtField.text != "" else {return}
        guard let address = addressTxtField.text, addressTxtField.text != "" else {return}
        guard let phone = phoneTxtField.text, phoneTxtField.text != "" else {return}
        guard phone != "" && phone.count == cityCount else {return}

        self.indicator.isHidden = false
        self.indicator.startAnimating()
        AuthService.instance.editUserInfo(name: name, address: address, phoneNumber: phone, email: email, cityID: cityId) { (success) in
            if success {
                self.nameTxtField.text = name
                self.addressTxtField.text = address
                self.phoneTxtField.text = phone
                self.emailTxtField.text = email
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                let alert = UIAlertController(title: "", message: "Your profile info updated successfully".localized, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                let when = DispatchTime.now() + 2
                DispatchQueue.main.asyncAfter(deadline: when){
                    alert.dismiss(animated: true, completion: nil)
                }

            }
        }

    }
    
    
    @IBAction func changeMobileBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func changePassBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toChangePassVC", sender: self)
    }
}

extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.pickerImage = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.pickerImage = originalImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

extension EditProfileVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if textField == codeTF{
//            return false
//        }
        return true
    }
}
