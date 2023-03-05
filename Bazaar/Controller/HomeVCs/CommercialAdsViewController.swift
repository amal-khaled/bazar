//
//  CommercialAdsViewController.swift
//  ArabOnline
//
//  Created by Amal Elgalant on 2/22/20.
//  Copyright © 2020 developer team. All rights reserved.
//

import UIKit
//import MSPeekCollectionViewDelegateImplementation

class CommercialAdsViewController: UIViewController {
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    @IBOutlet weak var totalItems: UILabel!
    @IBOutlet weak var currentIndex: UILabel!
    var commerceList : [Ad] = []
//    var behavior: MSCollectionViewPeekingBehavior!
    var selectedId  = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
//        behavior = MSCollectionViewPeekingBehavior()
//        behavior = MSCollectionViewPeekingBehavior(minimumItemsToScroll: 1)
        
//        sliderCollectionView.configureForPeekingBehavior(behavior: behavior)
////         behavior.scrollToItem(at: selectedId, animated: true)
//        behavior = MSCollectionViewPeekingBehavior(numberOfItemsToShow: 1)
//        sliderCollectionView.configureForPeekingBehavior(behavior: behavior)
        
        
        
        
       
        
        totalItems.text = String(commerceList.count)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.hidesBottomBarWhenPushed = true
        
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        if !self.hidesBottomBarWhenPushed{
            
            self.hidesBottomBarWhenPushed = false
            
        }
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func closeAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
        let vc = segue.destination as! CommericalAdDetailsViewController
        vc.commericalAd = commerceList[selectedId]
    }
    
    
    
}
extension CommercialAdsViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return commerceList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CommericalSliderCollectionViewCell
        cell.setData(commericalAd: commerceList[indexPath.row])
        cell.currentVC = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedId = indexPath.row
        self.performSegue(withIdentifier: "add_details", sender: self)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (( UIScreen.main.bounds.size.width)/1 )
        
        
        print(cellWidth)
        return CGSize(width: cellWidth, height:530)
        
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()

        visibleRect.origin = sliderCollectionView.contentOffset
        visibleRect.size = sliderCollectionView.bounds.size

        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

        guard let indexPath = sliderCollectionView.indexPathForItem(at: visiblePoint) else { return }
        self.currentIndex.text = String(indexPath.row + 1)

        print(indexPath)
    }

//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//
//
//        behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
//    }
    
    
}

