//
//  MapAndTableController.swift
//  On The Map
//
//  Created by Hunter Sparrow on 4/19/18.
//  Copyright © 2018 Hunter Sparrow. All rights reserved.
//

import UIKit
import MapKit

// refresh data in view protocol
protocol RefreshData {
    func refresh()
}

// fetch new data protocol
protocol FetchData {
    func fetchStarts ()
    func fetchEnds ()
}

// fetch
protocol AddLocation {
    func navigateToAddLocation ()
}

class MapAndTableController : UITabBarController {
    
    
    //Properties
    @IBOutlet var logoutButton: UIBarButtonItem!
    @IBOutlet var refreshButton: UIBarButtonItem!
    @IBOutlet var addButton: UIBarButtonItem!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchStudentLocations()
    }
    
    // MARK: Actions
    @IBAction func logoutButtonPressed(_ sender: Any) {
        fetchStarts()
        
        UdacityClient.sharedInstance().deleteToRemoveSessionID { (success, error) in
            if let error = error {
                print("There was an error at deleteToRemoveSessionID: \(error)")
                performUIUpdatesOnMain {
                    self.showAlert(text:error.localizedDescription)
                }
            }
            else if success{
                print("Logged out!!")
                self.dismiss(animated: true, completion: nil)
            }
            
            self.fetchEnds()
        }
    }
    
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        fetchStudentLocations()
    }
    
    // MARK: Network
    @IBAction func addButtonPressed(_ sender: Any) {
        fetchStarts()
        
        let _ = ParseClient.sharedInstance().getLastUserLocation() { (location, error) in
            
            if let error = error {
                print("There was an error at getUserLocation: \(error)")
                self.showAlert(text:error.localizedDescription)
            }
            
            if let location = location {
                let userName = "\"\(location.firstName ?? "") \(location.lastName ?? "")\""
                let message = "User \(userName) has already posted a student location. Would you like to overwrite their location?"
                self.showTwoButtonsAlert(text: message, viewController: self)
                print("getUserLocation has finished successfully")
            }
            
            else {
                self.navigateToAddLocation()
            }
            
           self.fetchEnds()
        }
    }
    

    func fetchStudentLocations() {
        StudentModel.sharedInstance.updateStudentsLocations(controller:self)
    }
}

extension MapAndTableController: FetchData {
    // MARK: UI
    func fetchStarts () {
        DispatchQueue.main.async {
            self.selectedViewController?.view.showBlurLoader()
            self.refreshButton.isEnabled = false
            self.addButton.isEnabled = false
            for item in self.tabBar.items! {
                item.isEnabled = false
            }
        }
    }
    
    func fetchEnds () {
        DispatchQueue.main.async {
            self.selectedViewController?.view.removeBlurLoader()
            self.refreshButton.isEnabled = true
            self.addButton.isEnabled = true
            for item in self.tabBar.items! {
                item.isEnabled = true
            }
            if let viewController = self.selectedViewController as? RefreshData {
               viewController.refresh()
            }
        }
    }
}


//present AddLocationViewController 
extension MapAndTableController: AddLocation {
    func navigateToAddLocation () {
        if let navController = navigationController {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddLocationController") as! AddLocationController
            navController.pushViewController(vc, animated: true)
        }
    }
}
