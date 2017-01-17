//
//  Venues.swift
//  ForMonz
//
//  Created by Joan on 17/01/2017.
//  Copyright © 2017 Joan. All rights reserved.
//

import Foundation
import ObjectMapper

class Venue: Mappable{
    
    var name:String?
    var id:String?
    var location: Dictionary<String, Any>?
    var categories: Array<AnyObject>?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        name    <- map["name"]
        id    <- map["id"]
        location    <- map["location"]
        categories    <- map["categories"]

    }
}


/*
 
 {
 allowMenuUrlEdit = 1;
 beenHere =             {
 lastCheckinExpiredAt = 0;
 };
 categories =             (
 {
 icon =                     {
 prefix = "https://ss3.4sqi.net/img/categories_v2/nightlife/pub_";
 suffix = ".png";
 };
 id = 4bf58dd8d48988d11b941735;
 name = Pub;
 pluralName = Pubs;
 primary = 1;
 shortName = Pub;
 }
 );
 id = 4ac518c3f964a52047a420e3;
 location =             {
 address = "51 Leverton St";
 cc = GB;
 city = "Kentish Town";
 country = "United Kingdom";
 crossStreet = "Railey Mews";
 formattedAddress =                 (
 "51 Leverton St (Railey Mews)",
 "Kentish Town",
 "Greater London",
 "NW5 2NX",
 "United Kingdom"
 );
 labeledLatLngs =                 (
 {
 label = display;
 lat = "51.552913";
 lng = "-0.139453";
 }
 );
 lat = "51.552913";
 lng = "-0.139453";
 postalCode = "NW5 2NX";
 state = "Greater London";
 };
 name = "The Pineapple";
 stats =             {
 checkinsCount = 2214;
 tipCount = 39;
 usersCount = 924;
 };
 verified = 0;
 
 */
