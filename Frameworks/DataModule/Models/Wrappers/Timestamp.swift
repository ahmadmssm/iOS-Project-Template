//
//  Timestamp.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 18/05/2021.
//

import Foundation
import CoreModule

public struct Timestamp: Decodable, Hashable {
    
    public var timeInterval: TimeInterval?
    public var formattedValue: String?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let date = try? container.decode(TimeInterval.self) {
            self.timeInterval = date
            self.formattedValue = self.getFormattedDate(dateString: String(date))
        }
    }
    
    private func getFormattedDate(dateString: String) -> String {
        return DateUtils.getFormattedDate(dateString: dateString,
                                          inputFormat: Constants.DateFormat.yearMonthDay.rawValue,
                                          outputFormat: Constants.DateFormat.dayMonthYearTime.rawValue)
    }
}
