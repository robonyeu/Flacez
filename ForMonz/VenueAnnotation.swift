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
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
