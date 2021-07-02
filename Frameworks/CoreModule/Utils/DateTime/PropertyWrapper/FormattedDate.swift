//
//  FormattedDate.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 16/04/2021.
//

import Foundation

/*
 How to use: just annotate any date String property with it
 Note: InputFormat must match the format of the date string and the outputFormat is the desired format.
 Ex:
 
 @FormattedDate
 var dateString: String?
 
 @FormattedDate(inputFormat: "yyyy-mm-dd HH:mm:ss")
 var dateString: String?
 
 
 @FormattedDate(outputFormat: "hh:mm:ss a")
 var dateString: String?
 */

@propertyWrapper
public struct FormattedDate: Codable, Hashable {
    
    private var value: String!
    private let inputFormat: String
    private let outputFormat: String
    
    public var wrappedValue: String! {
        get { value }
        set {
            value = self.getFormattedDate(dateString: newValue)
        }
    }
    
    public init(inputFormat: String = Constants.DateFormat.yearMonthDay.rawValue,
                outputFormat: String = Constants.DateFormat.dayMonthYearTime.rawValue) {
        self.inputFormat = inputFormat
        self.outputFormat = outputFormat
    }
    
    private func getFormattedDate(dateString: String) -> String {
        return DateUtils.getFormattedDate(dateString: dateString,
                                          inputFormat: self.inputFormat,
                                          outputFormat: self.outputFormat)
    }
}
