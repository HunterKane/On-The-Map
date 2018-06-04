//
//  DateUtils.swift
//  On The Map
//
//  Created by Hunter Sparrow on 4/19/18.
//  Copyright © 2018 Hunter Sparrow. All rights reserved.
//
import Foundation

extension DateFormatter {
    
    struct DateFormatterConstants {
        static let DateFormatString = "yyyy-MM-dd'T'HH:mm:ss.SZ"
    }
    
    func dateFromApiString (_ dateString: String) -> Date? {
        // Udacity dates look like: "2015-05-10T16:48:30.760460Z"
        self.dateFormat = DateFormatterConstants.DateFormatString
        self.timeZone = TimeZone(abbreviation: "UTC")
        self.locale = Locale(identifier: "en_US_POSIX")
        return self.date(from: dateString)
    }
}
