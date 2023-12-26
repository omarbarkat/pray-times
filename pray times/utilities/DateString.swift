//
//  DateString.swift
//  pray times
//
//  Created by Omar barkat on 05/12/2023.
//

import Foundation
import UIKit


extension Date {
    mutating func timeString (dateString : String) {
        let currentTime = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: currentTime)
        let currentMonth = calendar.component(.month, from: currentTime)
        let currentDay = calendar.component(.day, from: currentTime)
        let apiTimeString = "\(currentYear)" + " " + "\(currentMonth)" + " " + "\(currentDay)" + " " + "\(dateString)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd HH:mm (zzz)"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let apiDate = dateFormatter.date(from: apiTimeString)
    }
}

