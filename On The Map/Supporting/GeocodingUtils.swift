//
//  GeocodingUtils.swift
//  On The Map
//
//  Created by Hunter Sparrow on 4/19/18.
//  Copyright © 2018 Hunter Sparrow. All rights reserved.
//

import CoreLocation
import UIKit

func getCoordinatesForAddress (address: String, vc: UIViewController,_ completionHandlerForGeocoding: @escaping (_ result: CLPlacemark?, _ error: NSError?) -> Void) {
    let geocoder: CLGeocoder = CLGeocoder()
    geocoder.geocodeAddressString(address, completionHandler: { (geocodeResults, geocodeError) in
        
        // If geocoding returns an error do:
        if let error = geocodeError {
            let completionError = NSError(domain: "getCoordinatesForAddress", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error getting the location"])
            completionHandlerForGeocoding(nil, completionError)
            print ("Geocoder error: \(error.localizedDescription). Address string: \(address)")
        }
        
        // If the geocoding infomation is not complete do:
        guard let results = geocodeResults,
            let _ = results[0].location,
            let _ = results[0].name,
            let _ = results[0].country else {
                let completionError = NSError(domain: "getCoordinatesForAddress", code: 0, userInfo: [NSLocalizedDescriptionKey: "Location Not Found"])
                completionHandlerForGeocoding(nil, completionError)
                print ("Geocoder error: location, address or countru not found). Address: \(geocodeResults ?? [CLPlacemark]())")
                return
        }
        
        // successful if no errors
        completionHandlerForGeocoding(results[0], nil)
    })
}

