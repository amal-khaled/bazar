//
//  StoreViewController.swift
//  Bazaar
//
//  Created by Amal Elgalant on 13/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {
    
    @IBOutlet weak var collectionview: UICollectionView!
    var products = [Product]()
    @IBOutlet weak var cartBtn: UIBarButtonItem!
    var page = 1
    var isTheLastPage = false

    override func viewDidLoad() {
        super.viewDidLoad()
        getAllProducts()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if AppDelegate.cart.products.count > 0{
            cartBtn.addBadge(number: AppDelegate.cart.products.count)
        }else{
            cartBtn.removeBadge()
        }
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        basicPresentation(storyName: "Main", segueId: "mainTabBar")
    }
    @IBAction func cartBtnAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Store", bundle: nil).instantiateViewController(withIdentifier: "cart") as! CartViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension StoreViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "storeCollectionViewCell", for: indexPath) as! storeCollectionViewCell
        cell.setData(product: products[indexPath.row])
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.collectionview.bounds.width / 2) - 10
        return CGSize(width: size, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "Store", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        vc.product = products[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            let lastElement = products.count - 1
            if !isTheLastPage{
                if indexPath.row == lastElement {
                    self.page = page + 1
                    getAllProducts()
                }
            }
        
    }
}
extension StoreViewController{
    func getAllProducts(){
        
        StoreServices.instance.getAllProducts(page: page){
            products in
            if products.count == 0{
                self.isTheLastPage = true
                self.page = self.page - 1
            }
            else if self.page == 1 && products.count != 0{
                self.products = products
            }
            else{
                self.products.append(contentsOf: products)
            }
            self.collectionview.reloadData()
        }
    }
}
