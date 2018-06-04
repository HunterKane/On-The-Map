//
//  UrlUtils.swift
//  On The Map
//
//  Created by Hunter Sparrow on 4/18/18.
//  Copyright © 2018 Hunter Sparrow. All rights reserved.
//

import Foundation
import UIKit

let errorString = "Invalid Link"

func openUrlInSafari (urlString: String?, viewController: UIViewController) {
    let app = UIApplication.shared
    
    guard let urlString = urlString,
        let url = URL(string: urlString) else {
            viewController.showAlert(text: errorString)
            return
    }
    
    if (!app.openURL(url)) {
        viewController.showAlert(text: errorString)
    }
}
