//
//  String+Extensions.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 2/13/20.
//

import Foundation

public extension String {
    /// A localized value form Localizable base on current app local
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.resources, value: "", comment: "")
    }
    /// A Boolean value indicating whether a string has no characters after removing all whitespaces and all newlines.
    var hasValue: Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.count != 0
    }

    func toDate(format: Constants.DateFormat) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.amSymbol = Constants.amSymbol
        dateFormatter.pmSymbol = Constants.pmSymbol
        let date = dateFormatter.date(from: self)!
        return date
    }

    func removeWhiteSpaces() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func toURL() -> URL {
        return URL(string: self)!
    }
}
