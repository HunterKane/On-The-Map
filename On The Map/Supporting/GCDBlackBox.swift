//
//  GCDBlackBox.swift
//  On The Map
//
//  Created by Hunter Sparrow on 4/18/18.
//  Copyright © 2018 Hunter Sparrow. All rights reserved.
//

import Foundation


func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}


