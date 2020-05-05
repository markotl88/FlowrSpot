//
//  DateTests.swift
//  FlowrSpotTests
//
//  Created by Marko Stajic on 05/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import XCTest
@testable import FlowrSpot

class DateTests: XCTestCase {
    
    let validDates = ["2017-09-11T13:38:33.287Z",
                      "2019-06-26T07:28:43.142Z",
                      "2020-01-23T21:21:19.412Z"]
    
    let invalidDates = ["2017-13-11T13:38:33.287Z",
                        "2019-06-26T07:28:43.142S",
                        "2020-01-23T09:21:19.412ZPM"]
    
    var shortValidDates = ["2017 September 11",
                           "2019 June 26",
                           "2020 January 23"]

    var longValidDates = ["2017 September 11, 13:38",
                           "2019 June 26, 07:28",
                           "2020 January 23, 21:21"]
    
    var serbianShortValidDates = ["11.09.2017.",
                                  "26.06.2019.",
                                  "23.01.2020."]
    
    var serbianLongValidDates = ["11. septembar 2017, 13:38",
                                 "26. jun 2019, 07:28",
                                 "23. januar 2020, 21:21"]
    
    var serbianCyrillicLongValidDates = ["11. септембар 2017, 13:38",
                                         "26. јун 2019, 07:28",
                                         "23. јануар 2020, 21:21"]
    
    
    func testStringToDate() {
        
        for strDate in validDates {
            XCTAssertNotNil(strDate.date())
        }
        
        for strDate in invalidDates {
            XCTAssertNil(strDate.date())
        }
        
        for strDate in shortValidDates {
            XCTAssertNotNil(strDate.date(withDateFormat: .shortWithMonth))
        }
        
        for strDate in longValidDates {
            XCTAssertNotNil(strDate.date(withDateFormat: .longWithMonth))
        }

        for strDate in serbianShortValidDates {
            XCTAssertNotNil(strDate.date(withDateFormat: .serbianShort, andLocale: .srLatin))
        }

        for strDate in serbianLongValidDates {
            XCTAssertNotNil(strDate.date(withDateFormat: .serbianLong, andLocale: .srLatin))
        }

        for strDate in serbianCyrillicLongValidDates {
            XCTAssertNotNil(strDate.date(withDateFormat: .serbianLong, andLocale: .srCyrillic))
        }
    }
    
    func testDateToString() {
        
        let dates: [Date] = validDates.map { (strDate: String) -> Date in
            return strDate.date() ?? Date()
        }
        
        for (index, date) in dates.enumerated() {
            XCTAssertEqual(date.string(withDateFormate: .shortWithMonth), shortValidDates[index])
        }

        for (index, date) in dates.enumerated() {
            XCTAssertEqual(date.string(withDateFormate: .longWithMonth), longValidDates[index])
        }
        
        for (index, date) in dates.enumerated() {
            XCTAssertEqual(date.string(withDateFormate: .serbianShort, andLocale: .srLatin), serbianShortValidDates[index])
        }

        for (index, date) in dates.enumerated() {
            XCTAssertEqual(date.string(withDateFormate: .serbianLong, andLocale: .srCyrillic), serbianCyrillicLongValidDates[index])
        }
    }
}
