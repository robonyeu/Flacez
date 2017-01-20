//
//  VenueAnnotation.swift
//  ForMonz
//
//  Created by Joan on 20/01/2017.
//  Copyright © 2017 Joan. All rights reserved.
//

import Foundation
import MapKit

class VenueAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    var locationName: String
    var coordinate: CLLocationCoordinate2D
    let venue:Venue
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D, venue: Venue) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        self.venue = venue
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
