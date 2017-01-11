//
//  Metadata.swift
//  ForMonz
//
//  Created by Joan on 29/12/2016.
//  Copyright © 2016 Joan. All rights reserved.
//

import Foundation
import ObjectMapper

class Metadata: Mappable{
    
    var tags:String?
    var foursquareID:String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        tags    <- map["suggested_tags"]
        foursquareID  <- map["foursquare_id"]
    }
}
