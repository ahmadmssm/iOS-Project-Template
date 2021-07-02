//
//  DateFormatterAnnotationUnitTests.swift
//  CoreModuleTests
//
//  Created by Ahmad Mahmoud on 16/04/2021.
//

import XCTest
@testable import DataModule

class ModelWithDateString {
    
    @FormattedDate(outputFormat: "hh:mm:ss a")
    var dateString: String?
}

class DateFormatterAnnotationUnitTests: XCTestCase {
    
    func testExample() throws {
        let myClass = ModelWithDateString()
        myClass.dateString = "2016-02-29 12:24:26"
        assert((myClass.dateString != nil))
    }
}
