//
//  AdvertiseNowVC.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import MOLH
import SwiftyJSON
import OpalImagePicker
import Photos
import NVActivityIndicatorView

class AdvertiseNowVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var codeLbl: UILabel!
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
    @IBOutlet weak var catListBtn: UIButton!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var countryListBtn: UIButton!
    @IBOutlet weak var governListBtn: UIButton!
    @IBOutlet weak var AreaListBtn: UIButton!
    
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    @IBOutlet weak var phoneStackView: UIStackView!
    
    //Constants
    fileprivate let ImageCellId = "ImageCell"
    
    
    @IBOutlet weak var categoryManLbl: UILabel!
    @IBOutlet weak var countryManLbl: UILabel!
    
    @IBOutlet weak var governerateManLbl: UILabel!
    @IBOutlet weak var areaManLbl: UILabel!
    
    @IBOutlet weak var titleArabicManLbl: UILabel!
    
    @IBOutlet weak var phoneManLbl: UILabel!
    
    @IBOutlet weak var priceManLbl: UILabel!
    
    
    //Variables
    var images = [UIImage]()
    var AllowMessage: String = "false"
    var AllowCall: String = "false"
    var AdWithoutPhone: String = "false"
    var AutomaticRepublish: String = "false"
    var adId: Int = 0
    static var catId: Int = 0
    static var catTitleAr: String = ""
    static var catTitleEn: String = ""
    static var subCatId: Int = 0
    static var subCatTitleAr: String = ""
    static var subCatTitleEn: String = ""
    static var subSubCatId: Int = 0
    static var subSubCatTitleAr: String = ""
    static var subSubCatTitleEn: String = ""
    static var selectedCountry : String = ""
    //    var picker_Image: UIImage? {
    //        didSet {
    //            guard let image = picker_Image else { return }
    //            self.images.append(image)
    //            self.mainImg.image = images.first
    //            self.collectionView.reloadData()
    //            self.collectionViewHight.constant = 150
    //            self.collectionView.isHidden = false
    //        }
    //    }
    var goverList = [Governerate]()
    var areaList = [Area]()
    var selectedCountryId = -1
    var selectedGove = -1
    var selectedArea = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.isHidden = true
        setupView()
        setupCollectionView()
        self.phoneTxtField.textAlignment = NSTextAlignment.left
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            self.catListBtn.setTitle("\(AdvertiseNowVC.catTitleAr) - \(AdvertiseNowVC.subCatTitleAr) - \(AdvertiseNowVC.subSubCatTitleAr)", for: .normal)
        } else {
            self.catListBtn.setTitle("\(AdvertiseNowVC.catTitleEn) - \(AdvertiseNowVC.subCatTitleEn) - \(AdvertiseNowVC.subSubCatTitleEn)", for: .normal)
        }
        //        self.countryListBtn.setTitle("\(AdvertiseNowVC.selectedCountry)", for: .normal)
        
        if AppDelegate.defaults.string(forKey: "userCity") != nil{
            
            let cityId = Int(AppDelegate.defaults.string(forKey: "userCity") ?? "0")!
            self.selectedCountryId = cityId
            getGovernerate()
            var index = AppDelegate.countries.firstIndex(where: {$0.id == cityId}) ?? 0
            countryListBtn.setTitle(MOLHLanguage.currentAppleLanguage() == "ar" ? AppDelegate.countries[index].nameAr : AppDelegate.countries[index].nameEn, for: .normal)
            codeLbl.text = AppDelegate.countries[index].code
        }else{
            self.selectedCountryId = 1
            codeLbl.text = "+965"
            
            countryListBtn.setTitle("Kuwait".localized, for: .normal)
            
        }
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
        phoneView.addCornerRadius(cornerRadius: 20)
        phoneView.addBorder()
        nextBtn.addCornerRadius(cornerRadius: 25)
        collectionView.isHidden = true
        collectionViewHight.constant = 0
        mainImg.addCornerRadius(cornerRadius: 25)
        arabicTxtViewHight.constant = 100
        englishTxtViewHight.constant = 0
        titleArTextField.delegate = self
        titleEnTextField.delegate = self
        priceTxtField.delegate = self
        phoneTxtField.delegate = self
        arabicTxtView.delegate = self
        englishTxtView.delegate = self
        catListBtn.addCornerRadius(cornerRadius: 20)
        catListBtn.addBorder()
        titleEnTextField.text = " "
        countryListBtn.addCornerRadius(cornerRadius: 20)
        countryListBtn.addBorder()
        phoneView.semanticContentAttribute = .forceLeftToRight
        phoneStackView.semanticContentAttribute = .forceLeftToRight
        phoneTxtField.semanticContentAttribute = .forceLeftToRight
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: ImageCellId, bundle: nil), forCellWithReuseIdentifier: ImageCellId)
        collectionView.alwaysBounceHorizontal = true
    }
    
    func UPLOD(completion: @escaping CompletionHandler) {
        
        if AdvertiseNowVC.catId == 0 {
            catListBtn.borderColor = .red
            indicator.stopAnimating()
            
            categoryManLbl.textColor = .red
            return
        }
        catListBtn.borderColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
        
        categoryManLbl.textColor = #colorLiteral(red: 0.001686832751, green: 0.1439712048, blue: 0.4857619405, alpha: 1)
        //        if (phoneTxtField.text?.isPhoneNumber)! {
        guard let titleAr = titleArTextField.text, titleArTextField.text != "" else {
            let alert = UIAlertController(title: "", message: "Please enter the arabic title".localized, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
            titleArTextField.borderColor = .red
            indicator.stopAnimating()
            
            
            titleArabicManLbl.textColor = .red
            return
        }
        titleArTextField.borderColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
        
        titleArabicManLbl.textColor = #colorLiteral(red: 0.001686832751, green: 0.1439712048, blue: 0.4857619405, alpha: 1)
        
        let titleEn = titleEnTextField.text
        guard let price = priceTxtField.text, priceTxtField.text != "" else {
            let alert = UIAlertController(title: "", message: "Please enter the price".localized, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
                
            }
            priceManLbl.textColor = .red
            priceTxtField.borderColor = .red
            indicator.stopAnimating()
            return}
        priceManLbl.textColor = #colorLiteral(red: 0.001686832751, green: 0.1439712048, blue: 0.4857619405, alpha: 1)
        priceTxtField.borderColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
        guard let phone = phoneTxtField.text, phoneTxtField.text != "" && checkValidPhonNumber(Phone: "\(self.codeLbl.text!)\(phone)")
        else {
            let alert = UIAlertController(title: "", message: "Please enter the phone number".localized, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
            phoneManLbl.textColor = .red
            phoneView.borderColor = .red
            indicator.stopAnimating()
            
            return
            
        }
        phoneManLbl.textColor = #colorLiteral(red: 0.001686832751, green: 0.1439712048, blue: 0.4857619405, alpha: 1)
        phoneView.borderColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
        
        let englishDesc = englishTxtView.text
        let arabicDesc = arabicTxtView.text
        
        
        
        //            guard let arabicDesc = arabicTxtView.text, arabicTxtView.text != "" else {
        //                let alert = UIAlertController(title: "", message: "Please enter the arabic description".localized, preferredStyle: .alert)
        //                self.present(alert, animated: true, completion: nil)
        //                let when = DispatchTime.now() + 2
        //                DispatchQueue.main.asyncAfter(deadline: when){
        //                    alert.dismiss(animated: true, completion: nil)
        //                }
        //
        //                return}
        var parameters = [String:String]()
        let cityId = AppDelegate.defaults.string(forKey: "userCity") ?? "1"
        if AdvertiseNowVC.subCatId == 0 {
            parameters = [
                "CategoryId" : "\(AdvertiseNowVC.catId)",
                "SubCategoryId": "",
                "SubSubCategoryId": "",
                "Title": titleAr,
                "TitleEN": titleEn ?? " ",
                "DescriptionEN": englishDesc ?? " ",
                "Description": arabicDesc ?? " ",
                "PhoneNumber": phone,
                "AllowMessage": AllowMessage,
                "AllowCall": AllowCall,
                "AdWithoutPhone": AdWithoutPhone,
                "AutomaticRepublish": AutomaticRepublish,
                "AdPrice": price,
                "CityId": cityId,
                
            ]
        }
        else if AdvertiseNowVC.subSubCatId == 0 {
            parameters = [
                "CategoryId" : "\(AdvertiseNowVC.catId)",
                "SubCategoryId": "\(AdvertiseNowVC.subCatId)",
                "SubSubCategoryId": "",
                "Title": titleAr,
                "TitleEN": titleEn ?? " ",
                "DescriptionEN": englishDesc ?? " ",
                "Description": arabicDesc ?? " ",
                "PhoneNumber": phone,
                "AllowMessage": AllowMessage,
                "AllowCall": AllowCall,
                "AdWithoutPhone": AdWithoutPhone,
                "AutomaticRepublish": AutomaticRepublish,
                "AdPrice": price,
                "CityId": cityId,
            ]
        }
        else {
            parameters = [
                "CategoryId" : "\(AdvertiseNowVC.catId)",
                "SubCategoryId": "\(AdvertiseNowVC.subCatId)",
                "SubSubCategoryId": "\(AdvertiseNowVC.subSubCatId)",
                "Title": titleAr,
                "TitleEN": titleEn ?? " ",
                "DescriptionEN": englishDesc ?? " ",
                "Description": arabicDesc ?? " ",
                "PhoneNumber": phone,
                "AllowMessage": AllowMessage,
                "AllowCall": AllowCall,
                "AdWithoutPhone": AdWithoutPhone,
                "AutomaticRepublish": AutomaticRepublish,
                "AdPrice": price,
                "CityId": cityId,
            ] }
        
        if selectedGove != -1{
            parameters["GovernerateId"] = "\(selectedGove)"
        }
        if selectedArea != -1{
            parameters["AreaId"] = "\(selectedArea)"
            
        }
        Alamofire.upload(
            multipartFormData: { MultipartFormData in
                for (key, value) in parameters {
                    MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
                for i in 0..<self.images.count {
                    MultipartFormData.append(self.images[i].jpegData(compressionQuality: 0.1)!, withName: "photo [\(i)]", fileName: "file\(i).jpeg", mimeType: "image/jpeg")
                }
            }, to: UPLOAD_AD_URL, method: .post, headers: HEADER_BOTH) { (result) in
                switch result {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        let value = response.result.value
                        let json = JSON(value as Any)
                        if let adId = json["AdId"].int {
                            self.adId = adId
                        }
                        completion(true)
                    }
                case .failure(let encodingError):
                    print(encodingError.localizedDescription)
                    completion(false)
                    break
                }
            }
        //        }
        //    else {
        //            let alert = UIAlertController(title: "", message: "Please enter a correct number".localized, preferredStyle: .alert)
        //            self.present(alert, animated: true, completion: nil)
        //            let when = DispatchTime.now() + 2
        //            DispatchQueue.main.asyncAfter(deadline: when){
        //                alert.dismiss(animated: true, completion: nil)
        //            }
        //        }
    }
    
    
    @IBAction func uploadBtnPressed(_ sender: Any) {
        opalPicker()
    }
    
    func getAsset(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var image = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 500.0, height: 500.0), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            image = result!
        })
        return image
    }
    
    @IBAction func addImageBtnPressed(_ sender: Any) {
        opalPicker()
    }
    
    @IBAction func areaAction(_ sender: Any)
    {
        if selectedCountryId != -1{
            if areaList.count == 0{
                getArea(show: true)
            }else{
                showAreaList()
            }
        }
    }
    @IBAction func governAction(_ sender: Any)
    {
        if selectedCountryId != -1{
            
            if goverList.count == 0{
                getGovernerate(show: true)
            }else{
                showGovernList()
            }
        }
    }
    func opalPicker() {
        let imagePicker = OpalImagePickerController()
        imagePicker.selectionTintColor = UIColor.white.withAlphaComponent(0.7)
        imagePicker.selectionImageTintColor = UIColor.black
        imagePicker.maximumSelectionsAllowed = 8
        imagePicker.allowedMediaTypes = Set([.image])
        let configuration = OpalImagePickerConfiguration()
        configuration.maximumSelectionsAllowedMessage = NSLocalizedString("You can only select 8 images!".localized, comment: "")
        imagePicker.configuration = configuration
        presentOpalImagePickerController(imagePicker, animated: true,
                                         select: { (assets) in
            //Select Assets
            for i in 0..<assets.count {
                if self.images.count < 8 {
                    self.images.append(self.getAsset(asset: assets[i]))
                } else {
                    imagePicker.dismiss(animated: true, completion: nil)
                    let alert = UIAlertController(title: "", message: "You can only select 8 images!".localized, preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    let when = DispatchTime.now() + 2
                    DispatchQueue.main.asyncAfter(deadline: when){
                        alert.dismiss(animated: true, completion: nil)
                    }
                }
            }
            self.mainImg.image = self.images.first
            self.collectionView.reloadData()
            self.collectionViewHight.constant = 150
            self.collectionView.isHidden = false
            imagePicker.dismiss(animated: true, completion: nil)
        }, cancel: {
            imagePicker.dismiss(animated: true, completion: nil)
        })
    }
    
    @IBAction func englishBtnPressed(_ sender: Any) {
        arabicTxtViewHight.constant = 0
        englishTxtViewHight.constant = 100
    }
    
    @IBAction func arabicBtnPressed(_ sender: Any) {
        arabicTxtViewHight.constant = 100
        englishTxtViewHight.constant = 0
    }
    
    @IBAction func catListBtnPressed(_ sender: Any) {
        let categoryList = CategoryList()
        categoryList.modalPresentationStyle = .fullScreen
        categoryList.modalTransitionStyle = .crossDissolve
        present(categoryList, animated: true, completion: nil)
    }
    
    @IBAction func countryListBtnPressed(_ sender: Any) {
        //        let countryList = CountryListVC()
        //        countryList.modalPresentationStyle = .fullScreen
        //        countryList.modalTransitionStyle = .crossDissolve
        //        present(countryList, animated: true, completion: nil)
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
        indicator.isHidden = false
        indicator.startAnimating()
        if NetworkHelper.getToken() != nil {
            UPLOD { (success) in
                if success {
                    if AdvertiseNowVC.catId == 1 {
                        let alert = UIAlertController(title: "", message: "Your Ad got uploaded successfully".localized, preferredStyle: .alert)
                        self.indicator.stopAnimating()
                        self.indicator.isHidden = true
                        self.present(alert, animated: true, completion: nil)
                        let when = DispatchTime.now() + 2
                        DispatchQueue.main.asyncAfter(deadline: when){
                            alert.dismiss(animated: true, completion: nil)
                        }
                    } else {
                        self.indicator.stopAnimating()
                        self.indicator.isHidden = true
                        self.performSegue(withIdentifier: "toPayVC", sender: self)
                    }
                    //                    self.mainImg.image = UIImage()
                    //                    self.images.removeAll()
                    //                    self.collectionView.reloadData()
                    //                    self.collectionView.isHidden = true
                    //                    self.collectionViewHight.constant = 0
                    //                    AdvertiseNowVC.catId = 0
                    //                    AdvertiseNowVC.catTitleAr = ""
                    //                    AdvertiseNowVC.catTitleEn = ""
                    //                    AdvertiseNowVC.subCatId = 0
                    //                    AdvertiseNowVC.subCatTitleAr = ""
                    //                    AdvertiseNowVC.subCatTitleEn = ""
                    //                    AdvertiseNowVC.subSubCatId = 0
                    //                    AdvertiseNowVC.subSubCatTitleAr = ""
                    //                    AdvertiseNowVC.subSubCatTitleEn = ""
                    //                    self.catListBtn.setTitle("", for: .normal)
                    //                    self.titleEnTextField.text = ""
                    //                    self.titleArTextField.text = ""
                    //                    self.arabicTxtView.text = ""
                    //                    self.englishTxtView.text = ""
                    //                    self.phoneTxtField.text = ""
                    //                    self.priceTxtField.text = ""
                    //                    self.allowDMBtn.setImage(UIImage(named: "unchecked_rectangle"), for: .normal)
                    //                    self.allowCallsBtn.setImage(UIImage(named: "unchecked_rectangle"), for: .normal)
                    //                    self.hidePhoneBtn.setImage(UIImage(named: "unchecked_rectangle"), for: .normal)
                    //                    self.republishBtn.setImage(UIImage(named: "unchecked_rectangle"), for: .normal)
                }
            }
        } else {
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            performSegue(withIdentifier: "toLoginVC", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPayVC" {
            let destVC = segue.destination as! FeaturesVC
            destVC.adId = self.adId
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
        }))
        addActionSheetForiPad(actionSheet: alert)
        self.present(alert, animated: true, completion: {
        })
    }
}

//extension AdvertiseNowVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
//            self.picker_Image = editedImage
//        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            self.picker_Image = originalImage
//        }
//        picker.dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//}

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

extension UIViewController {
    public func addActionSheetForiPad(actionSheet: UIAlertController) {
        if let popoverPresentationController = actionSheet.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
    }
}
extension AdvertiseNowVC{
    func showGovernList(){
        let alertController = UIAlertController(title: "Choose Governrate".localized, message: "", preferredStyle: .actionSheet)
        
        for item in goverList{
            let superbutton = UIAlertAction(title: MOLHLanguage.currentAppleLanguage() == "ar" ? item.GovernerateAR : item.GovernerateEN , style: .default, handler: { (action) in
                //                self.codeTF.text = item.code
                //                self.selectedCountry = item
                //                self.countryBtn.setTitle(MOLHLanguage.currentAppleLanguage() == "ar" ? item.nameAr : item.nameEn , for: .normal)
                //                AppDelegate.cityId = item.id
                //
                //                AppDelegate.defaults.setValue(AppDelegate.cityId, forKey: "cityId")
                //                self.loadData()
                self.governListBtn.setTitle(MOLHLanguage.currentAppleLanguage() == "ar" ? item.GovernerateAR : item.GovernerateEN, for: .normal)
                self.selectedGove = item.GovernerateId!
                self.AreaListBtn.setTitle("", for: .normal)
                self.selectedArea = -1
                self.getArea()
                
            })
            
            alertController.addAction(superbutton)
        }
        let cancel = UIAlertAction(title: "Cancel".localized , style: .cancel, handler: { (action) in
            
            
        })
        alertController.addAction(cancel)
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view //to set the source of your alert
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
        }
        self.present(alertController, animated: true, completion: nil)
    }
    func getGovernerate(show: Bool = false){
        if selectedCountryId != -1 {
            UtilitiesService.instance.getGovernrate(completion: {
                check, gover in
                self.goverList = gover
                if show{
                    self.showGovernList()
                }
            }, countryId: self.selectedCountryId)
        }
    }
    
    func showAreaList(){
        let alertController = UIAlertController(title: "Choose Area".localized, message: "", preferredStyle: .actionSheet)
        
        for item in areaList{
            let superbutton = UIAlertAction(title: MOLHLanguage.currentAppleLanguage() == "ar" ? item.AreaAR : item.AreaEN , style: .default, handler: { (action) in
                
                self.AreaListBtn.setTitle(MOLHLanguage.currentAppleLanguage() == "ar" ? item.AreaAR : item.AreaEN, for: .normal)
                self.selectedArea = item.AreaId!
                
                
            })
            
            alertController.addAction(superbutton)
        }
        let cancel = UIAlertAction(title: "Cancel".localized , style: .cancel, handler: { (action) in
            
            
        })
        alertController.addAction(cancel)
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view //to set the source of your alert
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
        }
        self.present(alertController, animated: true, completion: nil)
    }
    func getArea(show: Bool = false){
        if selectedCountryId != -1 {
            UtilitiesService.instance.getArea(completion: {
                check, area in
                self.areaList = area
                if show{
                    self.showAreaList()
                }
            }, goverId: self.selectedGove)
        }
    }
}
