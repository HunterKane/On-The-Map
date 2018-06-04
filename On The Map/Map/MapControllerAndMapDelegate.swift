//
//  MapControllerAndMapDelegate.swift
//  On The Map
//
//  Created by Hunter Sparrow on 4/19/18.
//  Copyright © 2018 Hunter Sparrow. All rights reserved.
//

import UIKit
import MapKit


extension MapController: MKMapViewDelegate {
    
    // MARK: Properties
    static let DefaultMediaUrl = "www.udacity.com"
    
    func updateStudentLocationsInMap() {
        
        // Clear the map markers
        mapView.removeAnnotations(mapView.annotations)
        
        // We will create an MKPointAnnotation for each StudentLocation in "studentsLocations". The
        // point annotations will be stored in this array, and then provided to the map view.
        var annotations = [MKPointAnnotation]()
        
        // The "locations" array is loaded in MapController.
        for location in studentsLocations {
            
            // Notice that the float values are being used to create CLLocationDegree values.
            // This is a version of the Double type.
            var coordinate:CLLocationCoordinate2D? = nil
            if let lat = location.latitude,
                let long = location.longitude {
                
                // The lat and long are used to create a CLLocationCoordinates2D instance.
                coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees (lat), longitude: CLLocationDegrees (long))
            }
            
            // Get first name, last name and url
            let first = location.firstName ?? ""
            let last = location.lastName ?? ""
            let mediaURL = location.mediaUrl ?? MapController.DefaultMediaUrl
            
            //We create the annotation and set its coordiate, title, and subtitle properties
            if let coordinate = coordinate {
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(first) \(last)"
                annotation.subtitle = mediaURL
                
                // Append this annotation to the array.
                annotations.append(annotation)
            }
        }
        
        //Add the annotations to the map.
        self.mapView.addAnnotations(annotations)
        
    }
    
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
        
        
    }
    // MARK: mapView URL func to respond to taps. It opens the system browser
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)!, options: [:], completionHandler: { (success) in
                    if success == false {
                        print("FAIL TO OPEN URL")
                        return
                    }})
            }
        }
    }
    
    
    
}

