//
//  FlowrSpotUITests.swift
//  FlowrSpotUITests
//
//  Created by Marko Stajic on 05/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import XCTest

class FlowrSpotUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchBarAvailability() throws {
        // UI tests must launch the application that they test.
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        app.launch()
        
        let searchTextField = app.staticTexts["Looking for something specific?"]
        
        XCTAssertTrue(searchTextField.exists)
        XCTAssertTrue(searchTextField.isHittable)
        
        let lanCell = app.collectionViews.cells.staticTexts["Drobnolistni lan"]

        while !lanCell.exists {
            app.swipeUp()
        }
        
        XCTAssertTrue(app.staticTexts["Looking for something specific?"].exists)
        XCTAssertFalse(searchTextField.isHittable)
                
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.cells.containing(.staticText, identifier:"Lily").children(matching: .other).element(boundBy: 0).tap()
        
        XCTAssertFalse(app.staticTexts["Looking for something specific?"].isHittable)
    }
    
    func testSearchButtonExistence() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchButton = app.navigationBars["FlowrSpot"].buttons["plIconSearch"]
        
        XCTAssertFalse(searchButton.exists)
        
        let lanCell = app.collectionViews.cells.staticTexts["Drobnolistni lan"]

        while !lanCell.exists {
            app.swipeUp()
        }
        
        XCTAssertTrue(searchButton.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
