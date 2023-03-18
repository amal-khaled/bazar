//
//  ProfileDetailsVC.swift
//  Bazaar
//
//  Created by iOSayed on 18/03/2023.
//  Copyright © 2023 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class ProfileDetailsVC: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var followingsCountsLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var AdsCountLabel: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel:UILabel!
    @IBOutlet weak var userLocation:UILabel!
    @IBOutlet weak var userBioLabel:UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    //MARK: IBActions:
  
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismissDetail()
    }
    
    @IBAction func notificationBtnPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func shareBtnPressed(_ sender: UIButton) {
        print("shareBtnPressed")
    }
    
    @IBAction func myChatBtnPressed(_ sender: UIButton) {
        print("myChatBtnPressed")
    }
    
    @IBAction func editProfileBtnPressed(_ sender: UIButton) {
        print("editProfileBtnPressed")
    }
    
    @IBAction func showAllAdsBtnPressed(_ sender: UIButton) {
        print("showAllAdsBtnPressed")
    }
    
    @IBAction func callBtnPressed(_ sender: UIButton) {
        print("callBtnPressed")
    }
    
    
}
extension ProfileDetailsVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "hello"
        return cell
    }
    
    
}
