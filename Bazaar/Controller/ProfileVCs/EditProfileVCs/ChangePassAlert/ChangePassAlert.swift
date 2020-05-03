//
//  ChangePassAlert.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/6/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class ChangePassAlert: UIViewController {
    
    //Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var okBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        alertView.addCornerRadius(cornerRadius: 20)
        alertView.addBorder()
        okBtn.addCornerRadius(cornerRadius: 15)
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ChangePassAlert.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
