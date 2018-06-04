//
//  UIButtonCustom.swift
//  On The Map
//
//  Created by Hunter Sparrow on 4/18/18.
//  Copyright © 2018 Hunter Sparrow. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class UIButtonCustoms: UIButton {

    @IBInspectable var cornerRadius : CGFloat = 0 { didSet {
        self.layer.cornerRadius = cornerRadius
      }

   }
 
    
}
