//
//  SideMenuVC.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 1/27/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var languageBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func languageBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toLanguageVC", sender: self)
    }
}
