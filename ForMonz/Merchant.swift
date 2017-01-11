//
//  Merchant.swift
//  ForMonz
//
//  Created by Joan on 29/12/2016.
//  Copyright © 2016 Joan. All rights reserved.
//

import Foundation
import ObjectMapper

class Merchant: Mappable{
    
    var name:String?
    var metadata: Metadata?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        name    <- map["name"]
        metadata <- map["metadata"]
    }
}
