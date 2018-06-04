//
//  Stylistics.swift
//  On The Map
//
//  Created by Hunter Sparrow on 4/19/18.
//  Copyright © 2018 Hunter Sparrow. All rights reserved.
//

import Foundation
import UIKit

extension TableController {
    
    func addPullRefresh (tableView: UITableView, refreshControl: UIRefreshControl) {
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        }
        else {
            tableView.addSubview(refreshControl)
        }
        
        // Configure Refresh Control
        
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching student locations", attributes: [.foregroundColor: UIColor.blue])
        refreshControl.addTarget(self, action: #selector(fetchTableData(_:)), for: .valueChanged)
    }
}

