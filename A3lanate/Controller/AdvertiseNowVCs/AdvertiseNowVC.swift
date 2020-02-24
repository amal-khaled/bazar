//
//  AdvertiseNowVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 1/23/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class AdvertiseNowVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var uploadImgView: UIView!
    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var addImagesBtn: UIButton!
    @IBOutlet weak var descView: UIView!
    @IBOutlet weak var upperDescView: UIView!
    @IBOutlet weak var englishBtn: UIButton!
    @IBOutlet weak var arabicBtn: UIButton!
    @IBOutlet weak var desklineView: UIView!
    @IBOutlet weak var titleArTextField: UITextField!
    @IBOutlet weak var titleEnTextField: UITextField!
    @IBOutlet weak var priceTxtField: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var locTxtField: UITextField!
    @IBOutlet weak var allowDMBtn: UIButton!
    @IBOutlet weak var allowCallsBtn: UIButton!
    @IBOutlet weak var hidePhoneBtn: UIButton!
    @IBOutlet weak var republishBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var englishTxtView: UITextView!
    @IBOutlet weak var arabicTxtView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHight: NSLayoutConstraint!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var arabicTxtViewHight: NSLayoutConstraint!
    @IBOutlet weak var englishTxtViewHight: NSLayoutConstraint!
    
    //Constants
    fileprivate let ImageCellId = "ImageCell"
    
    //Variables
    var images = [UIImage]()
    var AllowMessage: String = "false"
    var AllowCall: String = "false"
    var AdWithoutPhone: String = "false"
    var AutomaticRepublish: String = "false"
    var picker_Image: UIImage? {
        didSet {
            guard let image = picker_Image else { return }
            self.images.append(image)
            self.mainImg.image = images.first
            self.collectionView.reloadData()
            self.collectionViewHight.constant = 150
            self.collectionView.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
    }
    
    func setupView() {
        self.navigationController?.navigationBar.addCornerRadius(cornerRadius: 25)
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        self.tabBarController?.tabBar.addCornerRadius(cornerRadius: 25)
        self.tabBarController?.tabBar.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        uploadImgView.addCornerRadius(cornerRadius: 25)
        addImagesBtn.addCornerRadius(cornerRadius: 25)
        addImagesBtn.addBorder()
        uploadImgView.addBorder()
        descView.addBorder()
        descView.addCornerRadius(cornerRadius: 25)
        descView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        titleArTextField.addCornerRadius(cornerRadius: 20)
        titleArTextField.addBorder()
        titleEnTextField.addCornerRadius(cornerRadius: 20)
        titleEnTextField.addBorder()
        priceTxtField.addCornerRadius(cornerRadius: 20)
        priceTxtField.addBorder()
        phoneTxtField.addCornerRadius(cornerRadius: 20)
        phoneTxtField.addBorder()
        locTxtField.addCornerRadius(cornerRadius: 20)
        locTxtField.addBorder()
        nextBtn.addCornerRadius(cornerRadius: 25)
        collectionView.isHidden = true
        collectionViewHight.constant = 0
        mainImg.addCornerRadius(cornerRadius: 25)
        arabicTxtViewHight.constant = 190
        englishTxtViewHight.constant = 0
        titleArTextField.delegate = self
        titleEnTextField.delegate = self
        priceTxtField.delegate = self
        phoneTxtField.delegate = self
        locTxtField.delegate = self
        arabicTxtView.delegate = self
        englishTxtView.delegate = self
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: ImageCellId, bundle: nil), forCellWithReuseIdentifier: ImageCellId)
        collectionView.alwaysBounceHorizontal = true
    }
    
    func UPLOD(completion: @escaping CompletionHandler) {
        guard let titleAr = titleArTextField.text, titleArTextField.text != "" else {
            let alert = UIAlertController(title: "", message: "Please enter the arabic title".localized, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
            return
        }
        guard let titleEn = titleEnTextField.text, titleEnTextField.text != "" else {
            let alert = UIAlertController(title: "", message: "Please enter the english title".localized, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
            return}
        guard let price = priceTxtField.text, priceTxtField.text != "" else {
            let alert = UIAlertController(title: "", message: "Please enter the arabic title".localized, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
            return}
        guard let phone = phoneTxtField.text, phoneTxtField.text != "" else {
            let alert = UIAlertController(title: "", message: "Please enter the phone number".localized, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
            return}
        guard let englishDesc = englishTxtView.text, englishTxtView.text != "" else {
            let alert = UIAlertController(title: "", message: "Please enter the english description".localized, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
            return}
        guard let arabicDesc = arabicTxtView.text, arabicTxtView.text != "" else {
            let alert = UIAlertController(title: "", message: "Please enter the arabic description".localized, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
            return}
        let parameters = [
            "CategoryId" : "4",
            "SubCategoryId": "50",
            "SubSubCategoryId": "100",
            "Title": titleAr,
            "TitleEN": titleEn,
            "DescriptionEN": englishDesc,
            "Description": arabicDesc,
            "PhoneNumber": phone,
            "AllowMessage": AllowMessage,
            "AllowCall": AllowCall,
            "AdWithoutPhone": AdWithoutPhone,
            "AutomaticRepublish": AutomaticRepublish,
            "AdPrice": price,
            "CityId": "1",
        ]
        Alamofire.upload(
            multipartFormData: { MultipartFormData in
                for (key, value) in parameters {
                    MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
                for i in 0..<self.images.count {
                    MultipartFormData.append(self.images[i].jpegData(compressionQuality: 1)!, withName: "photo [\(i)]", fileName: "file\(i).jpeg", mimeType: "image/jpeg")
                }
        }, to: UPLOAD_AD_URL, method: .post, headers: HEADER_BOTH) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print(response.result.value as Any)
                    completion(true)
                }
            case .failure(let encodingError):
                print(encodingError.localizedDescription)
                completion(false)
                break
            }
        }
    }
    
    
    @IBAction func uploadBtnPressed(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func addImageBtnPressed(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func englishBtnPressed(_ sender: Any) {
        arabicTxtViewHight.constant = 0
        englishTxtViewHight.constant = 190
    }
    
    @IBAction func arabicBtnPressed(_ sender: Any) {
        arabicTxtViewHight.constant = 190
        englishTxtViewHight.constant = 0
    }
    
    @IBAction func allowDMBtnPressed(_ sender: Any) {
        if allowDMBtn.image(for: .normal) == UIImage(named: "unchecked_rectangle") {
            allowDMBtn.setImage(UIImage(named: "checked_rectangle"), for: .normal)
            self.AllowMessage = "true"
        } else {
            allowDMBtn.setImage(UIImage(named: "unchecked_rectangle"), for: .normal)
            self.AllowMessage = "false"
        }
    }
    
    @IBAction func allowOnlineCallsBtnPressed(_ sender: Any) {
        if allowCallsBtn.image(for: .normal) == UIImage(named: "unchecked_rectangle") {
            allowCallsBtn.setImage(UIImage(named: "checked_rectangle"), for: .normal)
            self.AllowCall = "true"
        } else {
            allowCallsBtn.setImage(UIImage(named: "unchecked_rectangle"), for: .normal)
            self.AllowCall = "false"
        }
    }
    
    @IBAction func hidePhoneBtnPressed(_ sender: Any) {
        if hidePhoneBtn.image(for: .normal) == UIImage(named: "unchecked_rectangle") {
            hidePhoneBtn.setImage(UIImage(named: "checked_rectangle"), for: .normal)
            self.AdWithoutPhone = "true"
        } else {
            hidePhoneBtn.setImage(UIImage(named: "unchecked_rectangle"), for: .normal)
            self.AdWithoutPhone = "false"
        }
    }
    
    @IBAction func republishBtnPressed(_ sender: Any) {
        if republishBtn.image(for: .normal) == UIImage(named: "unchecked_rectangle") {
            republishBtn.setImage(UIImage(named: "checked_rectangle"), for: .normal)
            self.AutomaticRepublish = "true"
        } else {
            republishBtn.setImage(UIImage(named: "unchecked_rectangle"), for: .normal)
            self.AutomaticRepublish = "false"
        }
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        if NetworkHelper.getToken() != nil {
            UPLOD { (success) in
                if success {
                    self.performSegue(withIdentifier: "toPayVC", sender: self)
                }
            }
        } else {
            performSegue(withIdentifier: "toLoginVC", sender: self)
        }
    }
}
extension AdvertiseNowVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCellId, for: indexPath) as? ImageCell else {return UICollectionViewCell()}
        cell.adImg.image = images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Main".localized, style: .default , handler:{ (UIAlertAction)in
            self.mainImg.image = self.images[indexPath.row]
        }))
        
        alert.addAction(UIAlertAction(title: "Delete".localized, style: .destructive , handler:{ (UIAlertAction)in
            self.images.remove(at: indexPath.row)
            self.collectionView.reloadData()
            self.mainImg.image = self.images.first
            if self.images.count == 0 {
                self.collectionViewHight.constant = 0
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss".localized, style: .cancel, handler:{ (UIAlertAction)in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: {
        })
    }
}

extension AdvertiseNowVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.picker_Image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.picker_Image = originalImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension AdvertiseNowVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AdvertiseNowVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
