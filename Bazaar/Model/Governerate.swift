//
//  Governrate.swift
//  Bazaar
//
//  Created by Amal Elgalant on 22/02/2021.
//  Copyright © 2021 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation



struct Governerate : Codable{
    var GovernerateId: Int?
    var GovernerateAR: String?
    var GovernerateEN: String?
    
    enum CodingKeys: String, CodingKey {
        case GovernerateId
        case GovernerateAR
        case GovernerateEN
      
    }
    
}
