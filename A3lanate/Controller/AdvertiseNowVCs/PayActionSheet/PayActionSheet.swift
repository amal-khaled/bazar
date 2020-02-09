//
//  PayActionSheet.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/9/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class PayActionSheet: UIViewController {
    
    //Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var actionSheetView: UIView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var balanceBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        actionSheetView.addCornerRadius(cornerRadius: 50)
        actionSheetView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        onlineBtn.addCornerRadius(cornerRadius: 20)
        balanceBtn.addCornerRadius(cornerRadius: 20)
        cancelBtn.addCornerRadius(cornerRadius: 20)
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(PayActionSheet.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onlineBtnPressed(_ sender: Any) {
        let onlineActionSheet = OnlineActionSheet()
        onlineActionSheet.modalPresentationStyle = .custom
        present(onlineActionSheet, animated: true, completion: nil)
    }
    
    @IBAction func balanceBtnPressed(_ sender: Any) {
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
