//
//  AddLocationMapController.swift
//  On The Map
//
//  Created by Hunter Sparrow on 4/19/18.
//  Copyright © 2018 Hunter Sparrow. All rights reserved.
//

import UIKit
import MapKit

class AddLocationMapController: UIViewController {
   
    struct UserLocationUpdate {
        let location: CLLocation
        let address: String
        let mediaUrl: String
        
        // MARK: Initializers
        init(userLocation: CLLocation, userAddress: String, userMediaUrl: String, userName: String) {
            location = userLocation
            address = userAddress
            mediaUrl = userMediaUrl
        }
    }
    
    //Properties
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var finishButton: UIButton!
    
    var userLocationUpdate: UserLocationUpdate?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMarker()
    }
    
    //Update location of user once pressed
    @IBAction func finishButtonPressed(_ sender: Any) {
        
        if let location = StudentModel.sharedInstance.userLocation,
            let updatedLocation = userLocationUpdate,
            let objectId = location.objectId,
            let uniquekey = location.uniqueKey,
            let firstName = location.firstName,
            let lastName = location.lastName {
            
            let mapString = updatedLocation.address
            let mediaURL = updatedLocation.mediaUrl
            let latitude = updatedLocation.location.coordinate.latitude
            let longitude = updatedLocation.location.coordinate.longitude
            
            ParseClient.sharedInstance().updateStudentLocation(
                objectId: objectId, uniqueKey: uniquekey,
                firstName: firstName ,lastName: lastName,
                mapString: mapString, mediaURL: mediaURL,
                location: CLLocation(latitude: latitude, longitude: longitude)
                , { (success, error) in
                    if let error = error {
                        print("There was an error at updateStudentLocation: \(error)")
                        self.showAlert(text:error.localizedDescription, handler:self.handleConfirmPressed)
                    }
                    else {
                        self.popToMapAndTableController()
                    }
            })
        }
            
            // Post location of user 
        else {
            if let userLocation = StudentModel.sharedInstance.userLocation,
                let userLocationUpdate = userLocationUpdate,
                let udacitySession = UdacityClient.sharedInstance().udacitySession {
                ParseClient.sharedInstance().setStudentsNewLocation(
                    uniqueKey: udacitySession.userId,
                    firstName: userLocation.firstName ?? "",
                    lastName: userLocation.lastName ?? "",
                    mapString: userLocationUpdate.address,
                    mediaURL: userLocationUpdate.mediaUrl,
                    location: userLocationUpdate.location,
                    { (objectId, error) in
                        if let error = error {
                            print("There was an error at setStudentsNewLocation: \(error)")
                            self.showAlert(text:error.localizedDescription, handler:self.handleConfirmPressed)
                        }
                        else {
                            self.popToMapAndTableController()
                        }
                })
            }
            
        }
    }
    
    private func popToMapAndTableController () {
        for viewController in (navigationController?.viewControllers)! {
            if viewController is MapAndTableController {
                performUIUpdatesOnMain {
                    self.navigationController?.popToViewController(viewController, animated: true)
                }
            }
        }
    }
    
    
    private func handleConfirmPressed(alertAction:UIAlertAction) -> (){
        self.popToMapAndTableController()
    }
}


extension AddLocationMapController: MKMapViewDelegate {
    
    func addMarker() {
        mapView.removeAnnotations(mapView.annotations)
        
        if let userLocation = userLocationUpdate {
            let annotation = MKPointAnnotation()
            annotation.coordinate = userLocation.location.coordinate
            annotation.title = userLocation.address
            
            mapView.addAnnotation(annotation)
            centerMap(annotation.coordinate)
        }
        
    }
    
    // MARK: - MKMapViewDelegate / Pin image
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        if pinView == nil {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.image = #imageLiteral(resourceName: "icon_pin")
            pinView!.canShowCallout = true
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    
    func centerMap(_ coordinate: CLLocationCoordinate2D) {
        let mapRegion = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.01, 0.01))
        mapView.setRegion(mapRegion, animated: true)
    }
}

