//
//  UdacityConstants.swift
//  On The Map
//
//  Created by Hunter Sparrow on 4/19/18.
//  Copyright © 2018 Hunter Sparrow. All rights reserved.
//

import Foundation

extension UdacityClient {
    
    // MARK: UdacityConstants
    struct Constants {
        
        // MARK: UdacityURLs
        static let ApiScheme = "https"
        static let ApiHost = "www.udacity.com"
        static let ApiPath = "/api"
    }
    
    // MARK: UdacityMethods
    struct Methods {
        static let Session = "/session"
    }
    
    // MARK: Udacity Parameter Keys
    struct JSONBodyKeys {
        static let Udacity = "udacity"
        static let UserName = "username"
        static let Password = "password"
    }
    
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        static let Account = "account"
        static let Session = "session"
        static let Registered = "registered"
        static let SessionId = "id"
        static let Expiration = "expiration"
        static let UserKey = "key"
    }
    
}
