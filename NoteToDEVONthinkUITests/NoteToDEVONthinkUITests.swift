//
//  NoteToDEVONthinkUITests.swift
//  NoteToDEVONthinkUITests
//
//  Created by Adam Fallon on 4/27/18.
//  Copyright © 2018 Adam Fallon. All rights reserved.
//

import XCTest

class NoteToDEVONthinkUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
