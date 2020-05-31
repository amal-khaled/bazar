//
//  LocalizedCollectionView.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import MOLH

class LocalizedCollectionView: UICollectionViewFlowLayout {
    
    override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return MOLHLanguage.isArabic()
    }
}
