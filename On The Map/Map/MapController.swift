//
//  MapController.swift
//  On The Map
//
//  Created by Hunter Sparrow on 4/19/18.
//  Copyright © 2018 Hunter Sparrow. All rights reserved.
//
import MapKit
import UIKit 

class MapController : UIViewController, RefreshData {
    
    @IBOutlet var mapView: MKMapView!
    var studentsLocations: [StudentLocation] = [StudentLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        performUIUpdatesOnMain {
            self.refresh()
            
        }
        
    }
    
    // MARK: RefreshData func
    func refresh() {
        studentsLocations = StudentModel.sharedInstance.studentsLocations
        performUIUpdatesOnMain {
            self.updateStudentLocationsInMap()
        }
    }
    
}

