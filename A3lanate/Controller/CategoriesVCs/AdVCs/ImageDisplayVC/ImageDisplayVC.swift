//
//  ImageDisplayVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 3/24/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class ImageDisplayVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var downloadBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    
    //Variables
    var imgUrl: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadImage()
    }
    
    func setupView() {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ImageDisplayVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        self.downloadBtn.backgroundColor = UIColor.white
        self.downloadBtn.addCornerRadius(cornerRadius: 38)
    }
    
    func loadImage() {
        Alamofire.request(self.imgUrl).responseImage { (response) in
            if let image = response.result.value {
                DispatchQueue.main.async {
                    self.img.image = image
                    self.img.contentMode = .scaleAspectFit
                }
            }
        }
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error".localized, message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK".localized, style: .default))
            present(ac, animated: true)
        } else {
       
            let ac = UIAlertController(title: "Saved!".localized, message: "This picture has been saved to your photos.".localized, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK".localized, style: .default))
            present(ac, animated: true)
        }
    }
    
    @IBAction func downloadBtnPressed(_ sender: Any) {
        let image = self.img.image
        UIImageWriteToSavedPhotosAlbum(image!, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
