//
//  MyCVUITests.swift
//  MyCVUITests
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/21/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import XCTest

class MyCVUITests: XCTestCase {

    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
    }
    
    func testInformationScreenContainsSummary() {
        // Given
        let app = XCUIApplication()
        let expectation = XCTestExpectation(description: "Segue")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 4)
        
        // When
        let summary = app.staticTexts["Summary"]
        
        // Then
        XCTAssertTrue(summary.exists)
    }
    
    func testInformationScreenContainsLanguages() {
        // Given
        let app = XCUIApplication()
        let expectation = XCTestExpectation(description: "Segue")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 4)
        
        // When
        app.swipeUp()
        let languagesLabel = app.staticTexts["Languages"]
        
        // Then
        XCTAssertTrue(languagesLabel.exists)
    }
    
    func testInformationScreenContainsProgramming() {
        // Given
        let app = XCUIApplication()
        let expectation = XCTestExpectation(description: "Segue")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 4)
        
        // When
        app.swipeUp()
        let programmingLabel = app.staticTexts["Programming"]
        
        // Then
        XCTAssertTrue(programmingLabel.exists)
    }
    
    func testInformationScreenContainsWork() {
        // Given
        let app = XCUIApplication()
        let expectation = XCTestExpectation(description: "Segue")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 4)
        
        // When
        app.swipeUp()
        app.swipeUp()
        let workLabel = app.staticTexts["Work"]
        
        // Then
        XCTAssertTrue(workLabel.exists)
    }
    
    func testInformationScreenContainsEducation() {
        // Given
        let app = XCUIApplication()
        let expectation = XCTestExpectation(description: "Segue")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 4)
        
        // When
        app.swipeUp()
        app.swipeUp()
        app.swipeUp()
        let educationLabel = app.staticTexts["Education"]
        
        // Then
        XCTAssertTrue(educationLabel.exists)
    }
    
    func testInformationScreenContainsFullName() {
        // Given
        let app = XCUIApplication()
        let expectation = XCTestExpectation(description: "Segue")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 4)
        
        // When
        let nameLabel = app.staticTexts["Name"]
        
        // Then
        XCTAssertTrue(nameLabel.exists)
    }
}
