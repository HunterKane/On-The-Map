//
//  UdacityClientUtils.swift
//  On The Map
//
//  Created by Hunter Sparrow on 4/19/18.
//  Copyright © 2018 Hunter Sparrow. All rights reserved.
//

import Foundation

extension UdacityClient {
    
    // Replaces the key for the value
    func substituteKeyInJson(_ jsonPattern: String, key: String, value: String) -> String? {
        if jsonPattern.range(of: "{\(key)}") != nil {
            return jsonPattern.replacingOccurrences(of: "{\(key)}", with: value)
        }
        return nil
    }
    
    // Convert json to swift Dictionary
    func jsonFromDictionary(_ dictionary: [String : AnyObject]) -> Data {
        var jsonData: Data! = nil
        do {
            jsonData = try JSONSerialization.data(withJSONObject: dictionary)
            return jsonData
        } catch {
            print("Could not get josn from dictionary: '\(dictionary)'")
        }
        return Data()
    }
}
