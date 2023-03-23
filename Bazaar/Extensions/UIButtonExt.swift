//
//  UIButtonExt.swift
//  Bazaar
//
//  Created by iOSayed on 23/03/2023.
//  Copyright © 2023 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
//    /// to give left image to UIButton
//    func leftImage(image: UIImage, renderMode: UIImage.RenderingMode) {
//           self.setImage(image.withRenderingMode(renderMode), for: .normal)
//           self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
//           self.titleEdgeInsets.left = (self.frame.width/2) - (self.titleLabel?.frame.width ?? 0)
//           self.contentHorizontalAlignment = .left
//           self.imageView?.contentMode = .scaleAspectFit
//       }
//
//    ///to give right image to UIButton
//    func rightImage(image: UIImage, renderMode: UIImage.RenderingMode){
//            self.setImage(image.withRenderingMode(renderMode), for: .normal)
//            self.imageEdgeInsets = UIEdgeInsets(top: 0, left:image.size.width / 2, bottom: 0, right: 0)
//            self.contentHorizontalAlignment = .right
//            self.imageView?.contentMode = .scaleAspectFit
//        }
    
    /// to give left image to UIButton
    func leftIcon(image: UIImage) {
        self.setImage(image, for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: image.size.width)
      }
    
    ///to give right image to UIButton
    func rightIcon(image: UIImage) {
        self.setImage(image, for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: image.size.width, bottom: 0, right: 0)
      }
}
