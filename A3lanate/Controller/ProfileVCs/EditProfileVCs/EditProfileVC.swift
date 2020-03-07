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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        nameTxtField.delegate = self
        emailTxtField.delegate = self
        addressTxtField.delegate = self
        phoneTxtField.delegate = self
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
        
        AuthService.instance.editUserInfo(name: name, address: address, phoneNumber: phone, email: email) { (success) in
            if success {
                self.nameTxtField.text = name
                self.addressTxtField.text = address
                self.phoneTxtField.text = phone
                self.emailTxtField.text = email
                
                let alert = UIAlertController(title: "", message: "Your profile info updated successfully".localized, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when){
                    alert.dismiss(animated: true, completion: nil)
                }

            }
        }

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
}
