//
//  LocalizedCollectionView.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/16/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH

class LocalizedCollectionView: UICollectionViewFlowLayout {
    
    override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return MOLHLanguage.isArabic()
    }
}
