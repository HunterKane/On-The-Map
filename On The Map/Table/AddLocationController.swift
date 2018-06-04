//
//  AddLocationController.swift
//  On The Map
//
//  Created by Hunter Sparrow on 4/19/18.
//  Copyright © 2018 Hunter Sparrow. All rights reserved.
//

import UIKit
import CoreLocation

class AddLocationController: UIViewController {
    
    
    //MARK: Properties 
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var websiteTextField: UITextField!
    @IBOutlet var findLocationButton: UIButton!
  
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextField.delegate = self
        websiteTextField.delegate = self
        keyboardYLimit.buttonY = (findLocationButton?.frame.origin.y)! + self.view.frame.origin.y / self.view.frame.origin.y
        
    }
    
    //Keyboard
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotification()
    }
    //Keyboard
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeToKeyboardNotifications()
    }
    
    
    // Actions
    @IBAction func userDidTapView(_ sender: Any) {
        resignIfFirstResponder(locationTextField)
        resignIfFirstResponder(websiteTextField)
    }
    
    @IBAction func findLocationButtonPressed(_ sender: Any) {
        if locationTextField.text!.isEmpty ||
            websiteTextField.text!.isEmpty {
            self.showAlert(text:"Location or Website Empty.")
        }
        else {
            view.showBlurLoader()
            getCoordinatesForAddress(address: locationTextField.text!, vc: self, { (result, error) in
                
                DispatchQueue.main.async {
                    if let error = error {
                        
                        self.showAlert(text: error.localizedDescription)
                    }
                        
                    else if let result = result,
                        let location = result.location,
                        let name = result.name,
                        let country = result.country {
                        self.navigateToLocationPreview(location: location, name: name, country: country)
                    }
                    
                    self.view.removeBlurLoader()
                }
                
            })
        }
    }
    
    private func navigateToLocationPreview (location: CLLocation, name: String, country: String) {
        if let navController = navigationController {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddLocationMapController") as! AddLocationMapController
            vc.userLocationUpdate = AddLocationMapController.UserLocationUpdate(
                userLocation: location,
                userAddress: getCompleteAddressString(name: name, country: country),
                userMediaUrl: websiteTextField.text!,
                userName: getCompleteUserName())
            
            navController.pushViewController(vc, animated: true)
        }
    }
    
    private func getCompleteAddressString (name: String, country: String) ->String {
        var completeAddress = ""
        if name != "" {
            completeAddress = name
        }
        if country != "" {
            completeAddress += ", " + country
        }
        return completeAddress
    }
    
    private func getCompleteUserName () -> String {
        if let firstName  = StudentModel.sharedInstance.userLocation?.firstName,
            let lastName = StudentModel.sharedInstance.userLocation?.lastName {
            return firstName + ", " + lastName
        }
        else {
            return "Unknown name"
            
        }
    }
}

