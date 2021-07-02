//
//  DateUtils.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 18/05/2021.
//

import Foundation

public class DateUtils {
    public static func getFormattedDate(dateString: String,
                                        inputFormat: String,
                                        outputFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = inputFormat
        if let timeStamp = TimeInterval(dateString) {
            let dateFromTimeStamp = Date(timeIntervalSince1970: timeStamp)
            dateFormatter.dateFormat = outputFormat
            return dateFormatter.string(from: dateFromTimeStamp)
        }
        else if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = outputFormat
            return dateFormatter.string(from: date)
        }
        fatalError("\(dateString) format does not match the \(inputFormat)")
    }
}
