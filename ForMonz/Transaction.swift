//
//  Transaction.swift
//  ForMonz
//
//  Created by Joan on 29/12/2016.
//  Copyright © 2016 Joan. All rights reserved.
//

import Foundation
import ObjectMapper

class Transaction : Mappable{
    
    var merchant: Merchant?
    var notes: String?
    var created: String?
    
    //created:"2015-12-12T23:06:54.97Z"
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        merchant  <- map["merchant"]
        notes  <- map["notes"]
        created    <- (map["created"])
    }
    
}
