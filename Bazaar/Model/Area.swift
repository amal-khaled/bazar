//
//  Area.swift
//  Bazaar
//
//  Created by Amal Elgalant on 22/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation


struct Area : Codable{
    var AreaId: Int?
    var AreaAR: String?
    var AreaEN: String?
   
    enum CodingKeys: String, CodingKey {
        case AreaId
        case AreaAR
        case AreaEN
      
    }
    
}
