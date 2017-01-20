//
//  VenuesMapViewController.swift
//  ForMonz
//
//  Created by Joan on 20/01/2017.
//  Copyright © 2017 Joan. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class VenuesMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var locationManager: CLLocationManager!
    var similarVenues: Array<Venue> = []

    @IBOutlet weak var map: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        let regionRadius: CLLocationDistance = 1000
        

        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                      regionRadius * 2.0, regionRadius * 2.0)
            map.setRegion(coordinateRegion, animated: true)
        }
        
        if let userlocation = locationManager.location{
            centerMapOnLocation(location: userlocation)
        }
        else{
            let initialLocation = CLLocation(latitude: 51.5074, longitude: 0.1278)
            centerMapOnLocation(location: initialLocation)
        }
        
        
        for venue: Venue in similarVenues{
            
            let annotation: VenueAnnotation = VenueAnnotation(title: venue.name!, locationName: "", coordinate: (locationManager.location?.coordinate)!);
            
            if let formattedAdd = venue.location?["formattedAddress"] as? Array<String> {
               
                var formattedAddress = ""
                for address: String in formattedAdd {
                    formattedAddress += address + " "
                }
                
                annotation.locationName = formattedAddress
            }
            
            if let lat = venue.location?["lat"] {
                if let long = venue.location?["lng"] {
                    
                    
                    if let latFloat = lat as? Float{
                        if let lngFloat = long as? Float{
                            let initialLocation = CLLocation(latitude: Double(latFloat), longitude: Double(lngFloat))
                             annotation.coordinate = initialLocation.coordinate
                        }
                    }

                }
            }
           
            
            map.addAnnotation(annotation)
        }
        
        print("User is in \(locationManager)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("new location \(locations.last)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print(error)
    }

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotation = annotation as? VenueAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView { // 2
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
               // view.rightCalloutAccessoryView = UIButton.viewWithTag(.DetailDisclosure) as! UIView
                //view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclos ure) as! UIView
            }
            return view
        }
        return nil
    }
}
